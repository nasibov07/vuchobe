package com.vuchobe.api.service;

import com.vuchobe.api.dao.AuthUserDao;
import com.vuchobe.api.dao.PersonDao;
import com.vuchobe.api.dao.RoleDao;
import com.vuchobe.api.dao.StudentDao;
import com.vuchobe.api.model.v2.Role;
import com.vuchobe.api.model.v2.Student;
import com.vuchobe.api.model.v2.UserAuthEntity;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(
        readOnly = true
)
@AllArgsConstructor
public class StudentService {
    private final StudentDao studentDao;
    private final PersonDao personDao;
    private final AuthUserDao authUserDao;
    private final RoleDao roleDao;

    private final BCryptPasswordEncoder encoder;
    
    @Transactional
    public Long save(Student student) {
        if (student.getPerson() == null) throw new NullPointerException("person can't be null");
        if (student.getPerson().getUser() == null) throw new NullPointerException("auth data can't be null");
        Role role = createdStudentRoleIfEmpty(); // TODO Created Init script to DB

        UserAuthEntity user = student.getPerson().getUser();
        user.setRole(role);
        user.setPassword(encoder.encode(student.getPerson().getUser().getPassword()));
        authUserDao.save(user);
        personDao.save(student.getPerson());

        return studentDao.save(student).getId();
    }

    private Role createdStudentRoleIfEmpty() {
        return roleDao.findByAuthorityType(Role.RoleEnum.STUDENT)
                .orElseGet(() -> roleDao.save(new Role("Студент", Role.RoleEnum.STUDENT)));
    }
    
    @Transactional
    public Student update(Student student) {
        Student entity = studentDao.findById(student.getId())
                .orElseThrow(NullPointerException::new);
        
        entity.updateEntity(student);
        if (student.getPerson() != null && 
                student.getPerson().getUser() != null && 
                student.getPerson().getUser().getPassword() != null) {
            entity.getPerson().getUser()
                    .setPassword(encoder.encode(student.getPerson().getUser().getPassword()));
        }
        studentDao.save(entity);
        return entity;
    }    
    
    @Transactional
    public Student getById(Long id) {
        Student entity = studentDao.findById(id)
                .orElseThrow(NullPointerException::new);
        return entity;
    }
}
