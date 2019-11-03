package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.Faculty;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FacultyDao extends JpaRepository<Faculty, Long> {
    Faculty findByFullNameAndShortName(String fullName, String shortName);

    Page<Faculty> findAllByInstitute_Id(Long institute_Id,Pageable pageable);
}
