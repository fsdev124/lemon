

INSERT INTO PORTAL_WIDGET(ID,NAME,URL) VALUES(1,'待办任务','/rs/humantask/widget/personalTasks');
INSERT INTO PORTAL_WIDGET(ID,NAME,URL) VALUES(2,'我的实验','/rs/bpm/widget/runningProcesses');
INSERT INTO PORTAL_WIDGET(ID,NAME,URL) VALUES(3,'常用实验','/rs/bpm/widget/processes');
INSERT INTO PORTAL_WIDGET(ID,NAME,URL) VALUES(4,'通知公告','/rs/cms/widget/articles');
INSERT INTO PORTAL_WIDGET(ID,NAME,URL) VALUES(5,'常用工具','/widgets/tools.html');
INSERT INTO PORTAL_WIDGET(ID,NAME,URL) VALUES(6,'天气预报','/widgets/weather.html');


INSERT INTO PORTAL_INFO(ID,USER_ID,COLUMN_LAYOUT,SHARED_STATUS,GLOBAL_STATUS) VALUES(1,NULL,'4-4-4','true','true');


INSERT INTO PORTAL_ITEM(ID,NAME,COLUMN_INDEX,ROW_INDEX,INFO_ID,WIDGET_ID) VALUES(1,'待办任务',1,1,1,1);
INSERT INTO PORTAL_ITEM(ID,NAME,COLUMN_INDEX,ROW_INDEX,INFO_ID,WIDGET_ID) VALUES(2,'我的实验',2,1,1,2);
INSERT INTO PORTAL_ITEM(ID,NAME,COLUMN_INDEX,ROW_INDEX,INFO_ID,WIDGET_ID) VALUES(3,'常用实验',3,1,1,3);
INSERT INTO PORTAL_ITEM(ID,NAME,COLUMN_INDEX,ROW_INDEX,INFO_ID,WIDGET_ID) VALUES(4,'通知公告',1,2,1,4);
INSERT INTO PORTAL_ITEM(ID,NAME,COLUMN_INDEX,ROW_INDEX,INFO_ID,WIDGET_ID) VALUES(5,'常用工具',2,2,1,5);
INSERT INTO PORTAL_ITEM(ID,NAME,COLUMN_INDEX,ROW_INDEX,INFO_ID,WIDGET_ID) VALUES(6,'天气预报',3,2,1,6);


