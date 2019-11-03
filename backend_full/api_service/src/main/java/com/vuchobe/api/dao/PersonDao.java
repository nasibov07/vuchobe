package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonDao extends JpaRepository<Person, Long> {

}
