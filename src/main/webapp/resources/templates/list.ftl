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
<!-- 模态框--员工修改 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@example.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                        <#--部门提交部门ID 与数据库一致-->
                            <select class="form-control" id="emp_update_select" name="dId">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
            </div>
        </div>
    </div>
</div>
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
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@example.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
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
            <h1>MVC_Boot Demo</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
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
                        <th>
                            <input type="checkbox" class="check_item"/>
                        </th>
                    <#-- id去除千位分隔符 -->
                        <th>${emp.empId?replace(",","")}</th>
                    <#--<th>${emp.empId}</th>-->
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
                            <button class="btn btn-primary btn-sm edit_btn" edit-id="${emp.empId?replace(",","")}">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm delete_btn" del-id="${emp.empId?replace(",","")}">
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
        /*清除input控件上的颜色标志样式、文字，   一些非常规操作可能引起
        * 不清除掉   下一次操作ajax将失效*/
        reset_form("#empAddModal form");
        // 发送ajax获取部门信息并绑定select
        getDepts("#empAddModal select");
        // 弹出
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    // 弹出之前清除上一次表单里的内容
    // jquery没有reset方法，获取dom对象来调用reset
    function reset_form(ele) {
        $(ele)[0].reset();
        /*清空样式*/
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    /*查询部门信息显示到select*/
    function getDepts(ele) {
        $.ajax({
            url: "${request.contextPath}depts",
            type: "GET",
            success: function (result) {
                /*填充之前，先清空select*/
                $(ele).empty();
                //console.log(result);
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId)
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    function validate_add_form() {
        /*获取校验数据  使用正则*/
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,8})/;
        if (!regName.test(empName)) {
            show_validate_msg("#empName_add_input", "error", "用户名必须是2-5位中文字符或6-16位英文及数字、短横线、下划线组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "")
        }
        var email = $("#email_add_input").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "")
        }
        return true;
    }

    /*显示校验结果提示*/
    function show_validate_msg(ele, status, msg) {
        /*清除当前元素校验状态*/
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    /*姓名的input失去焦点时，发送ajax检测重名*/
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url: "${request.contextPath}checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    /*校验之后，添加状态到页面的class属性*/
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    /*提交模态框中的信息*/
    $("#emp_save_btn").click(function () {
        /*提交前，校验数据*/
        if (!validate_add_form()) {
            return false;
        }
        /*判断用户名重名校验是否成功*/
        if ($(this).attr("ajax-va") == "error") {
            show_validate_msg("#empName_add_input", "error", "请核对用户名信息无误");
            return false;
        }
        $.ajax({
            url: "${request.contextPath}emp",
            type: "POST",
            /*serialize的结果为 用于ajax的字符串，前提：表单中有name属性*/
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                /*alert(result.msg);*/
                if (result.code == 100) {
                    /*保存之后，关闭模态框，跳转最后一页查看*/
                    $("#empAddModal").modal('hide');
                    /*发送ajax显示最后一页 页码直接通过json中的信息来获取
                    * 插入时，如果最后一页正好是页面容量大小的数据，则只会
                    * 跳转到倒数第二页， 用最大页码+1即可解决 */
                    to_page(${json.pages+1});
                } else {
                    // 失败信息,如果字段验证通过则没有错误信息，值为undefined，取反判断
                    if (undefined != result.extend.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //姓名错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    function to_page(pn) {
        /*ajax可以访问到url,浏览器控制台可以看到正确的dom文档，
        但是页面无法刷新，没排查到具体原因，这里直接跳转
        初步认为是ftl模板内数据是通过后台json直接解析的原因*/
        window.location.href = '${request.contextPath}/emps?pn=' + pn;
    }

    /*按钮是先创建出的，在此处可以直接绑定click事件
    * 如果click事件在创建按钮之前给出，则会无法绑定事件
    * 如果按钮先由js创建了，（此案例由模板生成）
    * 则需要进行事件绑定  .live()
    * jquery新版没有live  可以用on 进行代替
    * 如：
    * $(document).on("click",".edit_btn",function(){   });
    * */
    $(".edit_btn").click(function () {
        getDepts("#empUpdateModal select");
        getEmp($(this).attr("edit-id"));
        // 把员工ID传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    /*单个删除*/
    $(".delete_btn").click(function () {
        /*弹框确认*/
        var empName = $(this).parents("tr").find("th:eq(2)").text();
        var empId = $(this).attr("del-id");
        if (confirm("确认删除【" + empName + "】吗？")) {
            $.ajax({
                url: "${request.contextPath}emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    to_page(${json.pageNum});
                }
            });
        }
    });

    function getEmp(id) {
        $.ajax({
            url: "${request.contextPath}emp/" + id,
            type: "GET",
            success: function (result) {
                console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                /*存在选中错乱的BUG   以前类似的写法没有遇见过，可能跟模板有关*/
                /*$("#empUpdateModal select").val([empData.dId]);*/
            }
        });
    }


    /*更新按钮  事件*/
    $("#emp_update_btn").click(function () {
        // 验证邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "")
        }
        /*保存*/
        $.ajax({
            url: "${request.contextPath}emp/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                /*跳转修改过的页*/
                to_page(${json.pageNum});
            }
        });
    });

    /*全选 全不选*/
    $("#check_all").click(function () {
        /*attr()获取checked时，为undefined
        * dom原生属性用prop
        * 自定义属性可以用attr*/
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    $(".check_item").click(function () {
        /*判断选中元素的个数，是否为页面中数据量的个数，如：页面每页8条数据*/
        var flag = $(".check_item:checked").length == $(".check_item").length
        $("#check_all").prop("checked", flag);
    });

    /*批量删除*/
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("th:eq(2)").text() + "，";
            /*用户删除的ID字符串*/
            del_idstr += $(this).parents("tr").find("th:eq(1)").text() + "-";
        });
        /*去除末尾多余逗号   -    */
        empNames = empNames.substring(0, empNames.length - 1);
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + empNames + "】吗？")) {
            $.ajax({
                url: "${request.contextPath}emp/" + del_idstr,
                type: "DELETE",
                success: function () {
                    to_page(${json.pageNum});
                }
            });
        }
    });
</script>
</body>
</html>