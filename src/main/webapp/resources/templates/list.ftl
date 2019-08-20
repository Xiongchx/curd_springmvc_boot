<#assign text>${pageInfo}</#assign>
<#assign json=text?eval/>
<!DOCTYPE html>
<html>
<head>
    <title>员工列表</title>
    <meta charset="UTF-8"/>
    <link href="resources/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="resources/static/js/jquery-1.12.4.min.js"></script>
    <script src="resources/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 模态框--员工添加 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@example.com">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                        <#--部门提交部门ID 与数据库一致-->
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>CURD_SpringMVC_Boot Demo</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                    <#list json.list as emp>
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>
                                <#if emp.gender=="M">
                                    男
                                <#else>
                                    女
                                </#if>
                        </th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                    </#list>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前页码【${json.pageNum}/${json.pages}】，共${json.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <#if !json.hasPreviousPage>
                        <li class="disabled"><a href="${request.contextPath}/emps?pn=1">首页</a></li>
                    <#else>
                        <li><a href="${request.contextPath}/emps?pn=1">首页</a></li>
                    </#if>
                        <#if json.hasPreviousPage>
                            <li>
                                <a href="${request.contextPath}/emps?pn=${json.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </#if>
                        <#list json.navigatepageNums as page_Num>
                            <#if json.pageNum == page_Num>
                                <li class="active"><a href="${request.contextPath}/emps?pn=${page_Num}">${page_Num}</a>
                                </li>
                            <#else>
                                <li><a href="${request.contextPath}/emps?pn=${page_Num}">${page_Num}</a></li>
                            </#if>

                        </#list>
                        <#if json.hasNextPage>
                            <li>
                                <a href="${request.contextPath}/emps?pn=${json.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </#if>
                    <#if !json.hasNextPage>
                        <li class="disabled"><a href="${request.contextPath}/emps?pn=${json.pages}">末页</a></li>
                    <#else>
                        <li><a href="${request.contextPath}/emps?pn=${json.pages}">末页</a></li>
                    </#if>
                </ul>
            </nav>
        </div>
    </div>
</div>
<script type="text/javascript">
    /*新增按钮弹出模态框*/
    $("#emp_add_modal_btn").click(function () {
        // 发送ajax获取部门信息并绑定select
        getDepts();
        // 弹出
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    /*查询部门信息显示到select*/
    function getDepts() {
        $.ajax({
            url: "${request.contextPath}depts",
            type: "GET",
            success: function (result) {
                /*填充之前，先清空select*/
                $("#empAddModal select").empty();
                //console.log(result);
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId)
                    optionEle.appendTo("#empAddModal select");
                });
            }
        });
    }

    /*提交模态框中的信息*/
    $("#emp_save_btn").click(function () {
        $.ajax({
            url:"${request.contextPath}emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                alert(result.msg);
            }
        });
    });
</script>
</body>
</html>