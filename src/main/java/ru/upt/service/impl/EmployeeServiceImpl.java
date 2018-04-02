package ru.upt.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.upt.model.Employee;
import ru.upt.model.Organization;
import ru.upt.repository.EmployeeCrudRepository;
import ru.upt.repository.OrganizationCrudRepository;
import ru.upt.repository.PersonCrudRepository;
import ru.upt.service.EmployeeService;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class EmployeeServiceImpl implements EmployeeService {
    private final EmployeeCrudRepository employeeCrudRepository;

    @Autowired
    public EmployeeServiceImpl(EmployeeCrudRepository employeeCrudRepository) {
        this.employeeCrudRepository = employeeCrudRepository;
    }

    @Override
    public List<Employee> getAll() {
        List<Employee> target = new ArrayList<Employee>();
        employeeCrudRepository.findAll().forEach(target::add);
        return target;
    }

    @Override
    public Employee getById(Long id) {
        return employeeCrudRepository.findOne(id);
    }

    @Override
    public Employee save(Employee employee) {
        return employeeCrudRepository.save(employee);
    }

    @Override
    public void delete(Employee employee) {
        employeeCrudRepository.delete(employee.getId());
    }
}
