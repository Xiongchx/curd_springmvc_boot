/**
 * FileName: Application
 * Author:   26917
 * Date:     2019/8/19 17:23
 * Description: 启动类
 * History:
 */
package com.boot.curd;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 〈一句话功能简述〉<br>
 * 〈启动类〉
 *
 * @author 26917
 * @create 2019/8/19
 * @since 1.0.0
 */
@SpringBootApplication
@MapperScan(basePackages = {"com.boot.curd.dao"})
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
