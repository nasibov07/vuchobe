package com.vuchobe.api.model;

import com.vuchobe.api.model.v2.Student;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

//@Entity
//@Table(name = "emproyer")
public class Employer {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(name = "name")
    private String value;

    @Column(name = "address")
    private String address;

    @ManyToMany
    @JoinTable(name = "employers_to_student",
            joinColumns = @JoinColumn(name = "student_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "employers_id", referencedColumnName = "id")
    )
    private Set<Student> students = new HashSet<>();


    public Employer() {
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Set<Student> getStudents() {
        return students;
    }

    public void setStudents(Set<Student> students) {
        this.students = students;
    }
}
