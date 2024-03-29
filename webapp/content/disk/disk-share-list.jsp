<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <title>文件管理</title>
    <%@include file="/common/s3.jsp"%>
	<link rel="stylesheet" href="${cdnPrefix}/public/mossle-disk/0.0.3/sprite_list_icon.css">
	<style type="text/css">
body {
    padding-top: 50px;
}
	</style>
  </head>
  <body>
    <div id="wrap">&nbsp;

<%@include file="/header/_disk.jsp"%>

      <div class="container-fluid" style="padding: 0px 15px 0;" id="top">

		<div class="row">
		  <%@include file="/menu/disk.jsp"%>

          <div class="col-md-10">
            <div class="alert-fixed-top" data-alerts="alerts" data-titles="{}" data-ids="myid" data-fade="1000"></div>

    <table id="tablereimburserecord1" class="table table-hover table-bordered">
      <thead>
        <tr>
          <th class="col-md-1 text-left"></th>
          <th class="col-md-7 text-left">文件名</th>
          <th class="col-md-2 text-left">分享时间</th>
        </tr>
      </thead>
      <tbody id="tbodyFileInfo">
	    <c:forEach items="${diskShares}" var="item">
        <tr>
		  <td class="text-center">
            <a href="javascript:void(0);removeFile(${item.id});"><i class="glyphicon glyphicon-remove"></i></a>
          </td>
          <td class="text-left">
		    <c:if test="${item.shareType == 'public'}">
			  <i class="glyphicon"></i>
			</c:if>
		    <c:if test="${item.shareType == 'private'}">
			  <i class="glyphicon glyphicon-lock"></i>
			</c:if>
		    <i class="icon-16 icon-16-${item.type}"></i>
			<c:if test="${item.type == 'dir'}">
			<a href="disk-share-list.do?path=${path}/${item.name}">
		    <span class="file-16-name">${item.name}</span>
			</a>
			</c:if>
			<c:if test="${item.type != 'dir'}">
		    <a href="disk-share-view.do?id=${item.id}">
			<span class="file-16-name">${item.name}</span>
			</a>
			</c:if>
			链接: <a href="${baseUrl}/disk/disk-view.do?id=${item.id}">${baseUrl}/disk/disk-view.do?id=${item.id}</a>
		    <c:if test="${item.shareType == 'private'}">
			  密码: ${item.sharePassword}
			</c:if>
			分享类型: 
		    <c:if test="${item.shareType == 'public'}">
			  公开
			</c:if>
		    <c:if test="${item.shareType == 'private'}">
			  私密
			</c:if>
	      </td>
          <td class="text-left"><fmt:formatDate value="${item.shareTime}" type="both"/></td>
        </tr>
		</c:forEach>
      </tbody>
    </table>

<div id="removeDialog" class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">确认删除？</h4>
      </div>
      <div class="modal-footer">
	  <form action="disk-share-remove.do" method="post">
	    <input type="hidden" name="path" value="${path}">
	    <input id="removeId" type="hidden" name="id" value="">
        <button id="removeCancelButton" type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button id="removeConfirmButton" type="submit" class="btn btn-primary">确认</button>
	  </form>
      </div>
	  </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
function removeFile(id) {
	$('#removeId').val(id);
	$('#removeDialog').modal("show");
}
</script>

          </div>
        </div><!--/col-->
      </div><!--/row-->
      <hr class="soften">
    </div>

    <%@include file="_footer.jsp"%>

  </body>
</html>
