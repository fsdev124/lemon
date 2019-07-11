<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/taglibs.jsp"%>
<%pageContext.setAttribute("currentHeader", "plm");%>
<%pageContext.setAttribute("currentMenu", "plm");%>
<!doctype html>
<html lang="en">

  <head>
    <%@include file="/common/meta.jsp"%>
    <title>列表</title>
    <%@include file="/common/s3.jsp"%>
    <script type="text/javascript">
var config = {
    id: 'pimInfoGrid',
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
	gridFormId: 'pimInfoGridForm',
	exportUrl: 'pim-info-export.do'
};

var table;

$(function() {
	table = new Table(config);
    table.configPagination('.m-pagination');
    table.configPageInfo('.m-page-info');
    table.configPageSize('.m-page-size');
});
    </script>

	<script type="text/javascript" src="${ctx}/s/ckeditor/ckeditor.js"></script>

    <script type="text/javascript">
$(function() {
	var editor = CKEDITOR.replace('plmIssueContent');
	editor.config.filebrowserImageUploadUrl = "plm-upload-image.do";
})
	</script>
  </head>

  <body>
    <%@include file="/header/plm.jsp"%>

    <div class="row-fluid">

      <!-- start of sidebar -->
<div class="panel-group col-md-2" id="accordion" role="tablist" aria-multiselectable="true" style="padding-top:65px;">

  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="collapse-header-user" data-toggle="collapse" data-parent="#accordion" href="#collapse-body-auth" aria-expanded="true" aria-col-md-5="collapse-body-auth">
      <h4 class="panel-title">
	    <i class="glyphicon glyphicon-list"></i>
        ${plmProject.name}
      </h4>
    </div>
    <div id="collapse-body-auth" class="panel-collapse collapse ${currentMenu == 'plm' ? 'in' : ''}" role="tabpanel" aria-labelledby="collapse-header-auth">
      <div class="panel-body">
        <ul class="nav nav-list">
		  <tags:isUser>
		  <li><a href="${tenantPrefix}/plm/create.do?projectId=${plmProject.id}"><i class="glyphicon glyphicon-list"></i> 新建任务</a></li>
		  </tags:isUser>
        </ul>
      </div>
    </div>
  </div>

		<footer id="m-footer" class="text-center">
		  <hr>
		  2019 &copy; lemon, by Diana
		</footer>

</div>

	  <!-- start of main -->
      <section id="m-main" class="col-md-10" style="padding-top:65px;">

<div class="panel panel-default">
  <div class="panel-heading">
	<i class="glyphicon glyphicon-list"></i>
    详情
  </div>
        <div class="panel-content">
<form id="car-infoForm" method="post" action="update.do" class="form-horizontal">
  <input type="hidden" name="id" value="${plmIssue.id}">
  <div class="form-group">
    <label class="control-label col-md-1" for="pimIssueProject">项目</label>
	<div class="col-md-10">
	  <p class="form-control-static">${plmProject.name}</p>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-1" for="pimIssueProject">类型</label>
	<div class="col-md-10">
	  <select name="type" class="form-control required">
	    <option value=""></option>
	    <option value="story" ${plmIssue.type == 'story' ? 'selected' : ''}>需求</option>
	    <option value="task" ${plmIssue.type == 'task' ? 'selected' : ''}>任务</option>
	    <option value="bug" ${plmIssue.type == 'bug' ? 'selected' : ''}>BUG</option>
	  </select>
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-1" for="car-info_name"><spring:message code="car-info.car-info.input.name" text="名称"/></label>
	<div class="col-md-10">
	  <input id="car-info_name" type="text" name="name" value="${plmIssue.name}" size="40" class="form-control required" minlength="2" maxlength="10">
    </div>
  </div>
  <div class="form-group">
    <label class="control-label col-md-1" for="plmIssueContent">描述</label>
	<div class="col-md-10">
	  <textarea id="plmIssueContent" name="content" class="form-control required" rows="6">${plmIssue.content}</textarea>
    </div>
  </div>
  <div class="form-group">
    <div class="col-md-11 col-md-offset-1">
      <button type="submit" class="btn btn-default a-submit"><spring:message code='core.input.save' text='保存'/></button>
	  &nbsp;
      <button type="button" class="btn btn-link a-cancel" onclick="history.back();"><spring:message code='core.input.back' text='返回'/></button>
    </div>
  </div>
</form>

        </div>
</div>
        <div class="m-spacer"></div>





      </section>
	  <!-- end of main -->
	</div>

  </body>

</html>


