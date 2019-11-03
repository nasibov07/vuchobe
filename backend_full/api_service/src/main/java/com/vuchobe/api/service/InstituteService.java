package com.vuchobe.api.service;

import com.vuchobe.api.dao.AddressDao;
import com.vuchobe.api.dao.InstituteDao;
import com.vuchobe.api.model.v2.Institute;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@AllArgsConstructor
@Transactional(
        readOnly = true
)
public class InstituteService {

    private InstituteDao instituteDao;
    private AddressDao addressDao;

    @Transactional
    public Institute save(Institute institute) {
        if (institute.getAddress() == null) throw new NullPointerException("Укажите адрес института");
        addressDao.save(institute.getAddress());
        return instituteDao.save(institute);
    }

    @Transactional
    public Institute update(Institute institute) {
        Institute institute1Entity = instituteDao.findById(institute.getId())
                .orElseThrow(() -> new NullPointerException("Факультат с таким идентификатором не найден"));
        institute1Entity.updateEntity(institute);
        if (institute1Entity.getAddress() != null && institute1Entity.getAddress().getId() == null) {
            addressDao.save(institute1Entity.getAddress());
        }
        return instituteDao.save(institute1Entity);
    }

    public Page<Institute> get(Pageable pageable) {
        return instituteDao.findAll(pageable);
    }
}
