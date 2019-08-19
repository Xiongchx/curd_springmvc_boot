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
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                    <#list pageInfo.getList() as emp>
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
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前页码【${pageInfo.pageNum}/${pageInfo.pages}】，共${pageInfo.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${request.contextPath}/emps?pn=1">首页</a></li>
                        <#if pageInfo.hasPreviousPage>
                            <li>
                                <a href="${request.contextPath}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </#if>
                        <#list pageInfo.navigatepageNums as page_Num>
                            <#if pageInfo.pageNum == page_Num>
                                <li class="active"><a href="${request.contextPath}/emps?pn=${page_Num}">${page_Num}</a>
                                </li>
                            <#else>
                                <li><a href="${request.contextPath}/emps?pn=${page_Num}">${page_Num}</a></li>
                            </#if>

                        </#list>
                        <#if pageInfo.hasNextPage>
                            <li>
                                <a href="${request.contextPath}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </#if>
                    <li><a href="${request.contextPath}/emps?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>