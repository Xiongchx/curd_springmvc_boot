/**
 * FileName: UserController
 * Author:   26917
 * Date:     2019/8/19 18:45
 * Description: test
 * History:
 */
package com.boot.curd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 〈一句话功能简述〉<br> 
 * 〈test〉
 *
 * @author 26917
 * @create 2019/8/19
 * @since 1.0.0
 */
@Controller
public class UserController {
    @GetMapping("/user")
    public String user(Model model){
        model.addAttribute("tip","用户数据");
        return "user";
    }
}
