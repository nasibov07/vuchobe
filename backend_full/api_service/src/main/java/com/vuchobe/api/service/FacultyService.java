package com.vuchobe.api.service;

import com.vuchobe.api.dao.AddressDao;
import com.vuchobe.api.dao.FacultyDao;
import com.vuchobe.api.dao.InstituteDao;
import com.vuchobe.api.model.v2.Faculty;
import com.vuchobe.api.model.v2.Institute;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;

@Service
@Transactional(
        readOnly = true
)
@AllArgsConstructor
public class FacultyService {
    private final FacultyDao facultyDao;
    private final InstituteDao instituteDao;
    private final AddressDao addressDao;

    @PostConstruct
    public void postConstructor() {
        //facultyDao.deleteAll();
        //highSchoolDao.deleteAll();
        /*List<HighSchool> vyzName = jsoupParser.createVuz();
        vyzName.forEach(vyz -> {
            vyz.getFaculties()
                    .forEach(faculty -> {
                        save(faculty);
                    });
        });*/
    }

    @Transactional
    public Faculty save(Faculty faculty) {
        if (faculty.getAddress() == null) {
            throw new NullPointerException("Необходимо заполнить адрес");
        }
        Institute institute = instituteDao.findById(faculty.getInstituteId())
                .orElseThrow(() -> new NullPointerException("Факультет с таким идентификатором не найден"));
        addressDao.save(faculty.getAddress());
        faculty.setInstitute(institute);
        return facultyDao.save(faculty);
    }

    @Transactional
    public Faculty update(Faculty faculty) {
        Faculty institute1Entity = facultyDao.findById(faculty.getId())
                .orElseThrow(() -> new NullPointerException("Факультат с таким идентификатором не найден"));
        institute1Entity.updateEntity(faculty);
        if (institute1Entity.getAddress() != null && institute1Entity.getAddress().getId() == null) {
            addressDao.save(institute1Entity.getAddress());
        }
        return facultyDao.save(institute1Entity);
    }

    public Page<Faculty> get(Pageable pageable) {
        return facultyDao.findAll(pageable);
    }
    
    public Page<Faculty> getByInstituteId(Long instituteId, Pageable pageable) {
        return facultyDao.findAllByInstitute_Id(instituteId, pageable);
    }

/*    @Override
    @Transactional
    public void delete(Long id) {
        Faculty entity = facultyDao.findById(id)
                .orElseThrow(NullPointerException::new);
        facultyDao.delete(entity);
    }*/
}
