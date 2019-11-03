package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentDao extends JpaRepository<Student, Long> {
    // List<Student> findByFirstNameOrLastName (String firstname, String lastname);
}
