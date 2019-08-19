package com.boot.curd.dao;

import com.boot.curd.bean.Employee;
import com.boot.curd.bean.EmployeeExample;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);

    /**
     * 不修改原有的查询，当需要做表连接查询时，比如需要在查询员工信息时，
     * 把部门也查出来（员工表只有部门id）
     *
     * 在员工对应的实体类 增加部门的 getter setter
     *
     * @author 26917
     * @date 2019/8/19 21:16
     * @param example
     * @return java.util.List<com.boot.curd.bean.Employee>
     */
    List<Employee> selectByExampleWithDept(EmployeeExample example);

    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
}