package com.vuchobe.api.model.v2;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity(name = "section_role")
public class Section {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column
    private String name;
    @Column
    private String value;

    @ManyToMany(mappedBy = "sections")
    private Set<Role> roles = new HashSet<>();

    public Section() {
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

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }
}
