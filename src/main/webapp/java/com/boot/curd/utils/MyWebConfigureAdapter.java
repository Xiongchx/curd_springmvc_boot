/**
 * FileName: MyWebConfigureAdapter
 * Author:   26917
 * Date:     2019/8/23 11:28
 * Description: 自定义资源映射
 * History:
 */
package com.boot.curd.utils;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 〈一句话功能简述〉<br> 
 * 〈自定义资源映射〉
 *
 * @author 26917
 * @create 2019/8/23
 * @since 1.0.0
 */
@Configuration
public class MyWebConfigureAdapter implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry){
        registry.addResourceHandler("/static/**").addResourceLocations("calsspath:/static/");
    }
}
