package com.mossle.disk.service;

import java.util.Date;
import java.util.List;

import javax.activation.DataSource;

import javax.annotation.Resource;

import com.mossle.api.store.StoreDTO;

import com.mossle.client.store.StoreClient;

import com.mossle.disk.persistence.domain.DiskInfo;
import com.mossle.disk.persistence.domain.DiskMember;
import com.mossle.disk.persistence.domain.DiskShare;
import com.mossle.disk.persistence.domain.DiskSpace;
import com.mossle.disk.persistence.manager.DiskInfoManager;
import com.mossle.disk.persistence.manager.DiskMemberManager;
import com.mossle.disk.persistence.manager.DiskShareManager;
import com.mossle.disk.persistence.manager.DiskSpaceManager;
import com.mossle.disk.util.FileUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Service;

@Service
public class DiskService {
    private static Logger logger = LoggerFactory.getLogger(DiskService.class);
    private DiskInfoManager diskInfoManager;
    private DiskSpaceManager diskSpaceManager;
    private DiskMemberManager diskMemberManager;
    private DiskShareManager diskShareManager;
    private StoreClient storeClient;

    /**
     * 显示对应用户，对应目录下的所有文件.
     */
    public List<DiskInfo> listFiles(String userId, String parentPath) {
        String hql = "from DiskInfo where creator=? and parentPath=? and status='active' order by dirType";

        return diskInfoManager.find(hql, userId, parentPath);
    }

    /**
     * 上传文件.
     */
    public DiskInfo createFile(String userId, DataSource dataSource,
            String name, long size, String parentPath, String tenantId)
            throws Exception {
        String modelName = "disk/user/" + userId;
        String keyName = parentPath + "/" + name;
        StoreDTO storeDto = storeClient.saveStore(modelName, keyName,
                dataSource, tenantId);
        String type = FileUtils.getSuffix(name);

        return this.createDiskInfo(userId, name, size, storeDto.getKey(), type,
                1, parentPath);
    }

    /**
     * 新建文件夹.
     */
    public DiskInfo createDir(String userId, String name, String parentPath) {
        // internalStoreConnector.mkdir("1/disk/user/" + userId + "/" + parentPath
        // + "/" + name);
        return this.createDiskInfo(userId, name, 0, null, "dir", 0, parentPath);
    }

    /**
     * 上传文件，或新建文件夹.
     */
    public DiskInfo createDiskInfo(String userId, String name, long size,
            String ref, String type, int dirType, String parentPath) {
        if (name == null) {
            logger.info("name cannot be null");

            return null;
        }

        name = name.trim();

        if (name.length() == 0) {
            logger.info("name cannot be empty");

            return null;
        }

        if (parentPath == null) {
            parentPath = "";
        } else {
            parentPath = parentPath.trim();
        }

        if (parentPath.length() != 0) {
            if (!parentPath.startsWith("/")) {
                parentPath = "/" + parentPath;
            }

            int index = parentPath.lastIndexOf("/");
            String targetParentPath = parentPath.substring(0, index);
            String targetName = parentPath.substring(index + 1);
            String hql = "from DiskInfo where parentPath=? and name=?";
            DiskInfo parent = diskInfoManager.findUnique(hql, targetParentPath,
                    targetName);

            if (parent == null) {
                logger.info("cannot find : {} {} {}", parentPath,
                        targetParentPath, targetName);

                return null;
            }
        }

        String hql = "select name from DiskInfo where creator=? and parentPath=?";
        List<String> currentNames = diskInfoManager.find(hql, userId,
                parentPath);
        String targetName = FileUtils.calculateName(name, currentNames);

        Date now = new Date();
        DiskInfo diskInfo = new DiskInfo();
        diskInfo.setName(targetName);
        diskInfo.setType(type);
        diskInfo.setFileSize(size);
        diskInfo.setCreator(userId);
        diskInfo.setCreateTime(now);
        diskInfo.setLastModifier(userId);
        diskInfo.setLastModifiedTime(now);
        diskInfo.setDirType(dirType);
        diskInfo.setRef(ref);
        diskInfo.setStatus("active");
        diskInfo.setParentPath(parentPath);
        diskInfoManager.save(diskInfo);

        return diskInfo;
    }

    /**
     * 删除.
     */
    public String remove(Long id) {
        DiskInfo diskInfo = diskInfoManager.get(id);

        if (diskInfo == null) {
            return "";
        }

        diskInfo.setStatus("trash");
        diskInfoManager.save(diskInfo);

        return diskInfo.getParentPath();
    }

    /**
     * 判断是否重复.
     */
    public boolean isDumplicated(String userId, String name, String path) {
        String hql = "from DiskInfo where creator=? and name=? and parentPath=?";

        return diskInfoManager.findUnique(hql, userId, name, path) != null;
    }

    /**
     * 重命名.
     */
    public String rename(String userId, Long id, String name) {
        DiskInfo diskInfo = diskInfoManager.get(id);
        String parentPath = diskInfo.getParentPath();
        String type = FileUtils.getSuffix(name);
        String hql = "select name from DiskInfo where creator=? and parentPath=? and id!=?";
        List<String> currentNames = diskInfoManager.find(hql, userId,
                parentPath, id);
        String targetName = FileUtils.calculateName(name, currentNames);
        diskInfo.setName(targetName);
        diskInfo.setType(type);
        diskInfoManager.save(diskInfo);

        return parentPath;
    }

    /**
     * 移动.
     */
    public String move(String userId, Long id, Long parentId) {
        DiskInfo diskInfo = diskInfoManager.get(id);
        String parentPath = diskInfo.getParentPath();

        if (id == parentId) {
            logger.info("{} is equals {}", id, parentId);

            return diskInfo.getParentPath();
        }

        if (parentId != 0) {
            DiskInfo parent = diskInfoManager.get(parentId);

            if (!"dir".equals(parent.getType())) {
                logger.info("{}({}) is not directory", parent.getParentPath()
                        + "/" + parent.getName(), parentId);

                return diskInfo.getParentPath();
            }

            String currentPath = diskInfo.getParentPath() + "/"
                    + diskInfo.getName() + "/";
            String checkedParentPath = parent.getParentPath() + "/";

            if ("dir".equals(diskInfo.getType())
                    && checkedParentPath.startsWith(currentPath)) {
                logger.info("{}({}) is sub directory of {}({})",
                        parent.getParentPath() + "/" + parent.getName(),
                        parentId,
                        diskInfo.getParentPath() + "/" + diskInfo.getName(), id);

                return diskInfo.getParentPath();
            }

            diskInfo.setParentPath(parent.getParentPath() + "/"
                    + parent.getName());
        } else {
            diskInfo.setParentPath("");
        }

        String name = diskInfo.getName();
        String hql = "select name from DiskInfo where creator=? and parentPath=? and id!=?";
        List<String> currentNames = diskInfoManager.find(hql, userId,
                parentPath, id);
        String targetName = FileUtils.calculateName(name, currentNames);
        diskInfo.setName(targetName);

        diskInfoManager.save(diskInfo);

        return parentPath;
    }

    // ~

    /**
     * 根据space显示文件列表.
     */
    public List<DiskInfo> listFiles(DiskSpace diskSpace, String parentPath) {
        if (parentPath == null) {
            parentPath = "";
        }

        String hql = "from DiskInfo where diskSpace=? and parentPath=? and status='active' order by dirType";

        return diskInfoManager.find(hql, diskSpace, parentPath);
    }

    /**
     * 根据space显示文件列表.
     */
    public List<DiskInfo> listFiles(DiskSpace diskSpace, String parentPath, String diskName) {
        if (parentPath == null) {
            parentPath = "";
        }

        if(diskName == null || diskName.length() == 0) {
        	String hql = "from DiskInfo where diskSpace=? and parentPath=? and status='active' order by dirType";
        	return diskInfoManager.find(hql, diskSpace, parentPath);
        } else {
        	String hql = "from DiskInfo where diskSpace=? and parentPath=? and name like ? and status='active' order by dirType";
        	return diskInfoManager.find(hql, diskSpace, parentPath, "%" + diskName + "%");
        }
    }
    
    /**
     * 根据share显示文件列表.
     */
    public List<DiskInfo> listFiles(DiskShare diskShare, String parentPath) {
        if (parentPath == null) {
            parentPath = "";
        }

        DiskInfo diskInfo = diskShare.getDiskInfo();
        DiskSpace diskSpace = diskInfo.getDiskSpace();
        String targetParentPath = diskInfo.getParentPath() + parentPath;

        return listFiles(diskSpace, targetParentPath);
    }

    /**
     * 上传文件.
     */
    public DiskInfo createFile(String userId, DataSource dataSource,
            String name, long size, String parentPath, Long spaceId,
            String tenantId) throws Exception {
        String modelName = "disk/user/" + userId;
        String keyName = parentPath + "/" + name;
        StoreDTO storeDto = storeClient.saveStore(modelName, keyName,
                dataSource, tenantId);
        String type = FileUtils.getSuffix(name);

        return this.createDiskInfo(userId, name, size, storeDto.getKey(), type,
                1, parentPath, spaceId);
    }

    /**
     * 新建文件夹.
     */
    public DiskInfo createDir(String userId, String name, String parentPath,
            Long spaceId) {
        // internalStoreConnector.mkdir("1/disk/user/" + userId + "/" + parentPath
        // + "/" + name);
        return this.createDiskInfo(userId, name, 0, null, "dir", 0, parentPath,
                spaceId);
    }

    /**
     * 上传文件，或新建文件夹.
     */
    public DiskInfo createDiskInfo(String userId, String name, long size,
            String ref, String type, int dirType, String parentPath,
            Long spaceId) {
        if (name == null) {
            logger.info("name cannot be null");

            return null;
        }

        name = name.trim();

        if (name.length() == 0) {
            logger.info("name cannot be empty");

            return null;
        }

        DiskSpace diskSpace = diskSpaceManager.get(spaceId);

        if (parentPath == null) {
            parentPath = "";
        } else {
            parentPath = parentPath.trim();
        }

        if (parentPath.length() != 0) {
            if (!parentPath.startsWith("/")) {
                parentPath = "/" + parentPath;
            }

            int index = parentPath.lastIndexOf("/");
            String targetParentPath = parentPath.substring(0, index);
            String targetName = parentPath.substring(index + 1);
            String hql = "from DiskInfo where parentPath=? and name=? and diskSpace=?";
            DiskInfo parent = diskInfoManager.findUnique(hql, targetParentPath,
                    targetName, diskSpace);

            if (parent == null) {
                logger.info("cannot find : {} {} {}", parentPath,
                        targetParentPath, targetName);

                return null;
            }
        }

        String hql = "select name from DiskInfo where creator=? and parentPath=? and diskSpace=?";
        List<String> currentNames = diskInfoManager.find(hql, userId,
                parentPath, diskSpace);
        String targetName = FileUtils.calculateName(name, currentNames);

        Date now = new Date();
        DiskInfo diskInfo = new DiskInfo();
        diskInfo.setName(targetName);
        diskInfo.setType(type);
        diskInfo.setFileSize(size);
        diskInfo.setCreator(userId);
        diskInfo.setCreateTime(now);
        diskInfo.setLastModifier(userId);
        diskInfo.setLastModifiedTime(now);
        diskInfo.setDirType(dirType);
        diskInfo.setRef(ref);
        diskInfo.setStatus("active");
        diskInfo.setParentPath(parentPath);
        diskInfo.setDiskSpace(diskSpace);
        diskInfoManager.save(diskInfo);

        return diskInfo;
    }

    /**
     * 根据用户id返回或创建这个用户的个人文档.
     */
    public DiskSpace findUserSpace(String userId) {
        DiskSpace diskSpace = diskSpaceManager.findUniqueBy("creator", userId);

        if (diskSpace == null) {
            diskSpace = new DiskSpace();
            diskSpace.setCatalog("user");
            diskSpace.setType("user");
            diskSpace.setCreator(userId);
            diskSpace.setCreateTime(new Date());
            diskSpaceManager.save(diskSpace);
        }

        return diskSpace;
    }

    /**
     * 查询或创建共享根目录.
     */
    public DiskShare findShare(Long infoId, String creator, String member) {
        DiskInfo diskInfo = diskInfoManager.get(infoId);
        DiskShare diskShare = diskShareManager.findUnique(
                "from DiskShare where diskInfo=? and creator=?", diskInfo,
                creator);

        if (diskShare == null) {
            diskShare = new DiskShare();
            diskShare.setName(diskInfo.getName());
            diskShare.setDiskInfo(diskInfo);
            diskShare.setCreator(creator);
            diskShare.setCatalog("internal");
            diskShareManager.save(diskShare);
        }

        this.addMember(diskShare, member);
        this.addMember(diskInfo.getDiskSpace(), member);

        return diskShare;
    }

    public void addMember(DiskShare diskShare, String member) {
        DiskMember diskMember = this.diskMemberManager.findUnique(
                "from DiskMember where diskShare=? and userId=?", diskShare,
                member);

        if (diskMember != null) {
            return;
        }

        diskMember = new DiskMember();
        diskMember.setDiskShare(diskShare);
        diskMember.setUserId(member);
        diskMemberManager.save(diskMember);
    }

    public void addMember(DiskSpace diskSpace, String member) {
        DiskMember diskMember = this.diskMemberManager.findUnique(
                "from DiskMember where diskSpace=? and userId=?", diskSpace,
                member);

        if (diskMember != null) {
            return;
        }

        diskMember = new DiskMember();
        diskMember.setDiskSpace(diskSpace);
        diskMember.setUserId(member);
        diskMemberManager.save(diskMember);
    }

    // ~
    @Resource
    public void setDiskInfoManager(DiskInfoManager diskInfoManager) {
        this.diskInfoManager = diskInfoManager;
    }

    @Resource
    public void setDiskSpaceManager(DiskSpaceManager diskSpaceManager) {
        this.diskSpaceManager = diskSpaceManager;
    }

    @Resource
    public void setDiskMemberManager(DiskMemberManager diskMemberManager) {
        this.diskMemberManager = diskMemberManager;
    }

    @Resource
    public void setDiskShareManager(DiskShareManager diskShareManager) {
        this.diskShareManager = diskShareManager;
    }

    @Resource
    public void setStoreClient(StoreClient storeClient) {
        this.storeClient = storeClient;
    }
}
