package com.vuchobe.api.model.v2;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity(name = "interest_type")
public class InterestType {

    @Id
    @GeneratedValue
    private Long id;

    @Column
    private String name;

    @Column
    private String value;

    @OneToMany(mappedBy = "type")
    private Set<Interest> interests = new HashSet<>();

    public InterestType() {
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

    public Set<Interest> getInterests() {
        return interests;
    }

    public void setInterests(Set<Interest> interests) {
        this.interests = interests;
    }
}
