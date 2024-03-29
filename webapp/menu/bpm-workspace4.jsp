<%@ page language="java" pageEncoding="UTF-8" %>
      <!-- start of sidebar -->
<style type="text/css">
#accordion .panel-heading {
	cursor: pointer;
}
#accordion .panel-body {
	padding:0px;
}
</style>

<div class="panel-group col-md-2" id="accordion" role="tablist" aria-multiselectable="true" style="padding-top:65px;">

  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="collapse-header-bpm-process" data-toggle="collapse" data-parent="#accordion" href="#collapse-body-bpm-process" aria-expanded="true" aria-controls="collapse-body-bpm-process">
      <h4 class="panel-title">
	    <i class="glyphicon glyphicon-list"></i>
        我的实验
      </h4>
    </div>
    <div id="collapse-body-bpm-process" class="panel-collapse collapse ${currentMenu == 'bpm-process' ? 'in' : ''}" role="tabpanel" aria-labelledby="collapse-header-bpm-process">
      <div class="panel-body">
        <ul class="nav nav-list">
		  <li><a href="${tenantPrefix}/bpm/workspace-listInvolvedProcessInstances2.do"><i class="glyphicon glyphicon-list"></i> 参与的实验</a></li>	 
        </ul>
      </div>
    </div>
  </div>

  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="collapse-header-task" data-toggle="collapse" data-parent="#accordion" href="#collapse-body-task" aria-expanded="true" aria-controls="collapse-body-task">
      <h4 class="panel-title">
	    <i class="glyphicon glyphicon-list"></i>
        我的任务
      </h4>
    </div>
    <div id="collapse-body-task" class="panel-collapse collapse ${currentMenu == 'task' ? 'in' : ''}" role="tabpanel" aria-labelledby="collapse-header-task">
      <div class="panel-body">
        <ul class="nav nav-list">
		  <li><a href="${tenantPrefix}/humantask/workspace-personalTasks.do"><i class="glyphicon glyphicon-list"></i> 待办任务</a></li>
		  <li><a href="${tenantPrefix}/humantask/workspace-groupTasks.do"><i class="glyphicon glyphicon-list"></i> 待领任务</a></li>
		  <li><a href="${tenantPrefix}/humantask/workspace-historyTasks.do"><i class="glyphicon glyphicon-list"></i> 已办任务</a></li>
		  <li><a href="${tenantPrefix}/humantask/workspace-delegatedTasks.do"><i class="glyphicon glyphicon-list"></i> 经手任务</a></li>
        </ul>
      </div>
    </div>
  </div>

  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="collapse-header-delegate" data-toggle="collapse" data-parent="#accordion" href="#collapse-body-delegate" aria-expanded="true" aria-controls="collapse-body-delegate">
      <h4 class="panel-title">
	    <i class="glyphicon glyphicon-list"></i>
        规则设置
      </h4>
    </div>
    <div id="collapse-body-delegate" class="panel-collapse collapse ${currentMenu == 'bpm-delegate' ? 'in' : ''}" role="tabpanel" aria-labelledby="collapse-header-delegate">
      <div class="panel-body">
        <ul class="nav nav-list">
		  <li><a href="${tenantPrefix}/delegate/delegate-listMyDelegateInfos.do"><i class="glyphicon glyphicon-list"></i> 代理规则</a></li>
		  <!--
		  <li><a href="#"><i class="glyphicon glyphicon-list"></i> 常用语</a></li>
		  -->
        </ul>
      </div>
    </div>
  </div>

</div>

      <!-- end of sidebar -->

