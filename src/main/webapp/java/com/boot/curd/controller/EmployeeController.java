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
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
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
}
