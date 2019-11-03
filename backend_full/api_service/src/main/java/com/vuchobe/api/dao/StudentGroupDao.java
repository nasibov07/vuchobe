package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.StudentGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentGroupDao extends JpaRepository<StudentGroup, Long> {
}
