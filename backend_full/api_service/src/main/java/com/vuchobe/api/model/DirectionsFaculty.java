package com.vuchobe.api.model;

import com.vuchobe.api.model.v2.Faculty;

import javax.persistence.*;

//@Entity
//@Table(name = "directions_faculty")
public class DirectionsFaculty {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "name")
    private String name;

    @ManyToOne
    private Faculty faculty;

    public DirectionsFaculty() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }
}

