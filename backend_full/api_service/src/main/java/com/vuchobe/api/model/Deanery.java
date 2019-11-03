package com.vuchobe.api.model;

import org.springframework.data.domain.Persistable;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//@Entity
//@Table(name = "deanery")
public class Deanery implements Persistable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public boolean isNew() {
        return null == this.getId();
    }
}

