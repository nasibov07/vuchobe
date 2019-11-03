package com.vuchobe.api.service;

import com.vuchobe.api.dao.FacultyDao;
import com.vuchobe.api.dao.StudentGroupDao;
import com.vuchobe.api.model.v2.Faculty;
import com.vuchobe.api.model.v2.Institute;
import com.vuchobe.api.model.v2.StudentGroup;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@AllArgsConstructor
public class StudentGroupService {

    private final StudentGroupDao studentgroupDao;
    private final FacultyDao facultyDao;

    @Transactional
    public StudentGroup save(StudentGroup studentGroup) {
        if (studentGroup.getFacultyId() == null) throw new NullPointerException("Необходимо передать id факультета."); 
        Faculty faculty = facultyDao.findById(studentGroup.getFacultyId())
                .orElseThrow(() -> new NullPointerException("Такого факультета нет"));
        studentGroup.setFaculty(faculty);
        return studentgroupDao.save(studentGroup);
    }

    @Transactional
    public StudentGroup update(StudentGroup studentGroup) {
        StudentGroup institute1Entity = studentgroupDao.findById(studentGroup.getId())
                .orElseThrow(() -> new NullPointerException("Факультат с таким идентификатором не найден"));
        institute1Entity.updateEntity(studentGroup);

        return studentgroupDao.save(institute1Entity);
    }

    public Page<StudentGroup> get(Pageable pageable) {
        return studentgroupDao.findAll(pageable);
    }

}
