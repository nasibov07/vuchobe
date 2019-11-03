package com.vuchobe.api.model.v2;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity(name = "interest")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Interest {

    @Id
    @GeneratedValue
    private Long id;

    @Column
    private String name;

    @Column
    private String value;

    @ManyToOne
    @JoinColumn(name = "interest_type_id")
    private InterestType type;
    
    @ManyToMany
    @JoinTable(
            name = "interest_to_activity",
            joinColumns = @JoinColumn(name = "interest_id"),
            inverseJoinColumns = @JoinColumn(name = "activity_id")
    )
    private Set<Activity> activities;

    @ManyToMany
    @JoinTable(
            name = "interest_to_person",
            joinColumns = @JoinColumn(name = "interest_id"),
            inverseJoinColumns = @JoinColumn(name = "person_id")
    )
    private Set<Person> persons = new HashSet<>();
}
