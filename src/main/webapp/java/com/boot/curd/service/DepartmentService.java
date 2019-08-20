/**
 * FileName: DepartmentService
 * Author:   26917
 * Date:     2019/8/20 17:11
 * Description:
 * History:
 */
package com.boot.curd.service;

import com.boot.curd.bean.Department;
import com.boot.curd.dao.DepartmentMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 〈一句话功能简述〉<br>
 * 〈〉
 *
 * @author 26917
 * @create 2019/8/20
 * @since 1.0.0
 */
@Service
public class DepartmentService {

    @Resource
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts() {
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
