<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/taglibs.jsp"%>
<%pageContext.setAttribute("currentHeader", "party");%>
<%pageContext.setAttribute("currentMenu", "party");%>
<!doctype html>
<html>

  <head>
    <%@include file="/common/meta.jsp"%>
    <title>编辑</title>
    <%@include file="/common/s3.jsp"%>
    <script type="text/javascript">
$(function() {
    $("#party-struct-typeForm").validate({
        submitHandler: function(form) {
			bootbox.animate(false);
			var box = bootbox.dialog('<div class="progress progress-striped active" style="margin:0px;"><div class="bar" style="width: 100%;"></div></div>');
            form.submit();
        },
        errorClass: 'validate-error'
    });
})
    </script>
  </head>

  <body>
    <%@include file="/header/party.jsp"%>

    <div class="row-fluid">
	  <%@include file="/menu/party.jsp"%>

	<!-- start of main -->
      <section id="m-main" class="col-md-10" style="padding-top:65px;">

      <div class="panel panel-default">
        <div class="panel-heading">
		  <i class="glyphicon glyphicon-list"></i>
		  编辑
		</div>

		<div class="panel-body">


<form id="orgStructTypeForm" method="post" action="party-struct-type-save.do" class="form-horizontal">
  <c:if test="${model != null}">
  <input id="orgStructType_id" type="hidden" name="id" value="${model.id}">
  </c:if>
  <div class="form-group">
	<label class="control-label col-md-1" for="orgStructType_name"><spring:message code="org.structtype.input.name" text="名称"/></label>
	<div class="col-sm-5">
      <input id="orgStructType_name" type="text" name="name" value="${model.name}" size="40" class="form-control required" maxlength="10">
    </div>
  </div>
  <div class="form-group">
	<label class="control-label col-md-1" for="orgStructType_ref">引用</label>
	<div class="col-sm-5">
      <input id="orgStructType_ref" type="text" name="ref" value="${model.ref}" size="40" class="text" maxlength="10">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-5">
      <button id="submitButton" class="btn"><spring:message code='core.input.save' text='保存'/></button>
      <button type="button" onclick="history.back();" class="btn"><spring:message code='core.input.back' text='返回'/></button>
    </div>
  </div>
</form>

		</div>

    </section>
	<!-- end of main -->
	</div>

  </body>

</html>

