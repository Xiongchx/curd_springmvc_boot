/**
 * FileName: EmployeeService
 * Author:   26917
 * Date:     2019/8/19 23:01
 * Description: service
 * History:
 */
package com.boot.curd.service;

import com.boot.curd.bean.Employee;
import com.boot.curd.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 〈一句话功能简述〉<br> 
 * 〈service〉
 *
 * @author 26917
 * @create 2019/8/19
 * @since 1.0.0
 */
@Service
public class EmployeeService {
    @Resource
    EmployeeMapper employeeMapper;

    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }
}
