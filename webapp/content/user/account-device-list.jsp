<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/taglibs.jsp"%>
<%pageContext.setAttribute("currentHeader", "account-device");%>
<%pageContext.setAttribute("currentMenu", "account-device");%>
<!doctype html>
<html lang="en">

  <head>
    <%@include file="/common/meta.jsp"%>
    <title><spring:message code="dev.account-device.list.title" text="列表"/></title>
    <%@include file="/common/s3.jsp"%>
    <script type="text/javascript">
var config = {
    id: 'account-deviceGrid',
    pageNo: ${page.pageNo},
    pageSize: ${page.pageSize},
    totalCount: ${page.totalCount},
    resultSize: ${page.resultSize},
    pageCount: ${page.pageCount},
    orderBy: '${page.orderBy == null ? "" : page.orderBy}',
    asc: ${page.asc},
    params: {
        'filter_LIKES_name': '${param.filter_LIKES_name}'
    },
	selectedItemClass: 'selectedItem',
	gridFormId: 'account-deviceGridForm',
	exportUrl: 'account-device-export.do'
};

var table;

$(function() {
	table = new Table(config);
    table.configPagination('.m-pagination');
    table.configPageInfo('.m-page-info');
    table.configPageSize('.m-page-size');
});
    </script>
  </head>

  <body>
    <%@include file="/header/account-device.jsp"%>

    <div class="row-fluid">
<%-- 	  <%@include file="/menu/account-device.jsp"%> --%>

	  <!-- start of main -->
      <section id="m-main" class="col-md-12" style="padding-top:65px;">

<!-- <div class="panel panel-default"> -->
<!--   <div class="panel-heading"> -->
<!-- 	<i class="glyphicon glyphicon-list"></i> -->
<!--     查询 -->
<!-- 	<div class="pull-right ctrl"> -->
<!-- 	  <a class="btn btn-default btn-xs"><i id="pimRemindSearchIcon" class="glyphicon glyphicon-chevron-up"></i></a> -->
<!--     </div> -->
<!--   </div> -->
<!--   <div class="panel-body"> -->

<!-- 		  <form name="account-deviceForm" method="post" action="account-device-list.do" class="form-inline"> -->
<%-- 		    <label for="account-device_name"><spring:message code='account-device.account-device.list.search.name' text='名称'/>:</label> --%>
<%-- 		    <input type="text" id="account-device_name" name="filter_LIKES_name" value="${param.filter_LIKES_name}" class="form-control"> --%>
<!-- 			<button class="btn btn-default a-search" onclick="document.account-deviceForm.submit()">查询</button>&nbsp; -->
<!-- 		  </form> -->

<!-- 		</div> -->
<!-- 	  </div> -->

<!--       <div style="margin-bottom: 20px;"> -->
<!-- 	    <div class="pull-left btn-group" role="group"> -->
<!-- 		  <button class="btn btn-default a-insert" onclick="location.href='account-device-input.do'">新建</button> -->
<!-- 		  <button class="btn btn-default a-remove" onclick="table.removeAll()">删除</button> -->
<!-- 		  <button class="btn btn-default a-export" onclick="table.exportExcel()">导出</button> -->
<!-- 		</div> -->

<!-- 		<div class="pull-right"> -->
<!-- 		  每页显示 -->
<!-- 		  <select class="m-page-size form-control" style="display:inline;width:auto;"> -->
<!-- 		    <option value="10">10</option> -->
<!-- 		    <option value="20">20</option> -->
<!-- 		    <option value="50">50</option> -->
<!-- 		  </select> -->
<!-- 		  条 -->
<!--         </div> -->

<!-- 	    <div class="clearfix"></div> -->
<!-- 	  </div> -->

<form id="account-deviceGridForm" name="account-deviceGridForm" method='post' action="account-device-remove.do" class="m-form-blank">
      <div class="panel panel-default">
        <div class="panel-heading">
		  <i class="glyphicon glyphicon-list"></i>
		  <spring:message code="scope-info.scope-info.list.title" text="列表"/>
		</div>

  <table id="scope-infoGrid" class="table table-hover">
    <thead>
      <tr>
<!--         <th width="10" class="m-table-check"><input type="checkbox" name="checkAll" onchange="toggleSelectedItems(this.checked)"></th> -->
		<!--
        <th class="sorting" name="id"><spring:message code="account-device.account-device.list.id" text="编号"/></th>
		-->
        <th class="sorting" name="name">名称</th>
        <th class="sorting" name="name">操作</th>
<!--         <th class="sorting" name="name">客户端</th> -->
        <th class="sorting" name="name">操作时间</th>
<!--         <th class="sorting" name="name">最近访问</th> -->
<!--         <th class="sorting" name="name">状态</th> -->
<!--         <th width="80">&nbsp;</th> -->
      </tr>
    </thead>

    <tbody>
      <c:forEach items="${page.result}" var="item">
      <tr>
<%--         <td><input type="checkbox" class="selectedItem a-check" name="selectedItem" value="${item.id}"></td> --%>
		<!--
        <td>${item.id}</td>
		-->
        <td>${item.name}</td>
<%--         <td>${item.os}</td> --%>
        <td>${item.operation}</td>
        <td><fmt:formatDate value="${item.time}" type="both"/></td>
<%--         <td><fmt:formatDate value="${item.lastLoginTime}" type="both"/></td> --%>
<%--         <td>${item.status}</td> --%>
<!--         <td> -->
<%--           <a href="account-device-input.do?id=${item.id}" class="a-update"><spring:message code="core.list.edit" text="编辑"/></a> --%>
<!--         </td> -->
      </tr>
      </c:forEach>
    </tbody>
  </table>
      </div>
</form>

	  <div>
	    <div class="m-page-info pull-left">
		  共100条记录 显示1到10条记录
		</div>

		<div class="btn-group m-pagination pull-right">
		  <button class="btn btn-default">&lt;</button>
		  <button class="btn btn-default">1</button>
		  <button class="btn btn-default">&gt;</button>
		</div>

	    <div class="clearfix"></div>
      </div>

      <div class="m-spacer"></div>

      </section>
	  <!-- end of main -->
	</div>

  </body>

</html>
