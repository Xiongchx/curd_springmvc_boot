/**
 * FileName: DefaultView
 * Author:   26917
 * Date:     2019/8/20 2:31
 * Description: 默认访问首页
 * History:
 */
package com.boot.curd.utils;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 〈一句话功能简述〉<br>
 * 〈默认访问首页〉
 *
 * @author 26917
 * @create 2019/8/20
 * @since 1.0.0
 */
@Configuration
public class DefaultView implements WebMvcConfigurer {
    /**
     * WebMvcConfigurerAdapter被弃用了
     * 但是实现了WebMvcConfigurer 接口
     * 所以实现此接口然后重写addViewControllers方法即可
     *
     * localhost:8080即可访问到指定的url下，实现默认访问页的设置
     *
     * @author 26917
     * @date 2019/8/20 2:38
     * @param registry
     * @return void
     */
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:/emps");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
    }
}
