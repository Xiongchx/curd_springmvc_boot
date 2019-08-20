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
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * 〈一句话功能简述〉<br>
 * 〈controller〉
 *
 * @author 26917
 * @create 2019/8/19
 * @since 1.0.0
 */
@Controller
public class EmployeeController {
    //用logger展示json信息，用于在ftl中解析
    //private Logger logger=Logger.getLogger(EmployeeController.class);

    @Autowired
    EmployeeService employeeService;

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
}
