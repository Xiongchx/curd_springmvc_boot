/**
 * FileName: DepartmentController
 * Author:   26917
 * Date:     2019/8/20 17:10
 * Description: 部门控制器
 * History:
 */
package com.boot.curd.controller;

import com.alibaba.fastjson.JSON;
import com.boot.curd.bean.Department;
import com.boot.curd.service.DepartmentService;
import com.boot.curd.utils.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 〈一句话功能简述〉<br> 
 * 〈部门控制器〉
 *
 * @author 26917
 * @create 2019/8/20
 * @since 1.0.0
 */

/*此处控制器直接使用RestController注解，防止控制其内方法出现500*/
@RestController
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门信息
     * @author 26917
     * @date 2019/8/20 17:13
     * @param
     * @return java.lang.String
     */
    @GetMapping("/depts")
    public Msg getDepts(Model model){
        // 查出的所有部门
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts",list);
    }
}
