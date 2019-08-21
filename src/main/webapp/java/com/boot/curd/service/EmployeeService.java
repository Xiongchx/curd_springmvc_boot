/**
 * FileName: EmployeeService
 * Author:   26917
 * Date:     2019/8/19 23:01
 * Description: service
 * History:
 */
package com.boot.curd.service;

import com.boot.curd.bean.Employee;
import com.boot.curd.bean.EmployeeExample;
import com.boot.curd.dao.EmployeeMapper;
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

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /* true 可用  false 不可用*/
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }
}
