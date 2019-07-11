<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
<!doctype html>
<html lang="en">

  <head>
    <%@include file="/common/meta.jsp"%>
    <title>重置密码</title>
	<%@include file="/common/s3.jsp"%>
  </head>

  <body>

    <!-- start of header bar -->
<div class="navbar navbar-default navbar-fixed-top header-style">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="${tenantPrefix}">
	    <img src="${cdnPrefix}/public/mossle/0.0.11/logo32.png" class="img-responsive pull-left" style="margin-top:-5px;margin-right:5px;">
	    实验管理系统 <sub><small>1.0.0</small></sub>
      </a>
    </div>

    <div class="navbar-collapse collapse">

      <ul class="nav navbar-nav navbar-right">
	    <li>
          <a href="?locale=zh_CN"><img src="${cdnPrefix}/public/flags/0.0.11/china.gif" height="20"></a>
		</li>
	    <li>
          <a href="?locale=en_US"><img src="${cdnPrefix}/public/flags/0.0.11/us.gif" height="20"></a>
		</li>
	  </ul>
	</div>
  </div>
</div>
    <!-- end of header bar -->

	<div class="row" style="margin-top:70px;">
	  <div class="container-fluid">

	  <div class="col-md-4"></div>

	<!-- start of main -->
    <section class="col-md-4">

      <article class="panel panel-default">
        <header class="panel-heading">
		  重置密码
		</header>

		<div class="panel-body">

          修改密码成功，<a href="../common/login.jsp">登录</a>

        </div>
      </article>

      <div class="m-spacer"></div>
	</section>
	<!-- end of main -->

	  <div class="col-md-4"></div>
	  </div>
    </div>

  </body>
</html>
