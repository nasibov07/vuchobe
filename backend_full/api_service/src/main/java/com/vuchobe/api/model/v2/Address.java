package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.views.Views;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Set;

@Entity(name = "address")
@Data
@NoArgsConstructor
public class Address {

    @Id
    @GeneratedValue
    private Long id;

    @Column(length = 550)
    @JsonView({Views.List.class, Institute.View.Save.class, Faculty.View.Save.class, Activity.View.Save.class,})
    private String fullAddress;
    @Column
    private String city;
    @Column
    private String street;
    
    @Column
    private String house;
    @Column
    private String index;

    @OneToOne(mappedBy = "address")
    @JsonIgnore
    private Faculty faculty;

    @OneToOne(mappedBy = "address")
    @JsonIgnore
    private Institute institute;
    
    @OneToMany(mappedBy = "address")
    @JsonIgnore
    private Set<Activity> activity;
}
