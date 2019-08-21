/**
 * FileName: EmployeeController
 * Author:   26917
 * Date:     2019/8/19 22:54
 * Description: controller
 * History:
 */
package com.boot.curd.controller;

import com.alibaba.fastjson.JSON;
import com.boot.curd.bean.Employee;
import com.boot.curd.service.EmployeeService;
import com.boot.curd.utils.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 〈一句话功能简述〉<br>
 * 〈controller〉
 *
 * @author 26917
 * @create 2019/8/19
 * @since 1.0.0
 */
/*这里没有RestController，去方法中单独配@ResponseBody
 * 此控制器中，/emps 配了默认访问页（DefaultView类），控制器配@RestController的话默认访问页将失效 */
@Controller
public class EmployeeController {
    //用logger展示json信息，用于在ftl中解析
    //private Logger logger=Logger.getLogger(EmployeeController.class);

    @Autowired
    EmployeeService employeeService;

    /*员工保存
     * 使用JSR303校验，需要Hibernate-Validator依赖包*/
    @PostMapping("/emp")
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            /*校验失败，返回相应的信息，去模态框中显示错误信息*/
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段：" + fieldError.getField());
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @GetMapping("/emps")
    public String getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //引入分页插件，startPage其后紧跟的查询为分页查询
        PageHelper.startPage(pn, 8);
        List<Employee> emps = employeeService.getAll();
        // 包装查询结果，由PageInfo封装详细的分页信息，然后将PageInfo交给页面处理
        // 构造器中的第二个参数为连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        // 封装通用格式 json 字符串
        model.addAttribute("pageInfo", JSON.toJSONString(page));
        //logger.debug(JSON.toJSONString(page));
        return "list";
    }

    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkuser(@RequestParam("empName") String empName) {
        // 判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,8})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名必须是2-5位中文字符或6-16位英文及数字、短横线、下划线组合");
        }
        // 是否重复校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    @GetMapping("/emp/{id}")
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /*PutMapping中的id要求字段和数据库一致，否则为null

      如果ajax直接发type:"PUT"的请求
    * 封装的数据除了PutMapping中的empId，其他的全部为NULL
    * 具体为请求体有数据，但是Employee对象封装不上
    * 原因：  Tomcat将请求体中的数据封装一个Map
    *
    *        request.getParameter(xxx"")就会从这个Map取值
    *
    *        SprinMVC封装实体类对象的时候，会把实体类每个属性的值，
    *        调用request.getParamter("xxx")拿到
    * PUT请求，请求体中的数据，request.getParamter("xxx")是不能获取到的
    * Tomcat遇到PUT请求则不会封装请求体的数据为Map,
    * 只有POST形式的请求才封装请求体为Map
    *
    * 解决：
    * Boot框架默认会过滤PUT请求，不需要单独配置
    * SpringMVC+Spring的话需要单独配置HttpPutFormContentFilter过滤器
    *
    * 此过滤器会将PUT的请求体包装为request可用的数据，也就是Map
    * 然后重写了getParameter,从它自己封装的Map里取数据
    * */
    @PutMapping(value = "/emp/{empId}")
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
}
