package com.vuchobe.api.model;

import org.springframework.data.domain.Persistable;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//@Entity
//@Table(name = "high_school")
public class HighSchool implements Persistable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column
    private String value;
//
//    @OneToMany(mappedBy = "vyz")
//    private Set<Faculty> faculties = new HashSet<>();

    public HighSchool() {
    }

    public HighSchool(String value) {
        this.value = value;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
//
//    public Set<Faculty> getFaculties() {
//        return faculties;
//    }
//
//    public void setFaculties(Set<Faculty> faculties) {
//        this.faculties = faculties;
//    }

    @Override
    public boolean isNew() {
        return null == this.getId();
    }

}
