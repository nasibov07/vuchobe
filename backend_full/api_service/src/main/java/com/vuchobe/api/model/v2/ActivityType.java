package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Set;

@Entity
@NoArgsConstructor
@Data
@EqualsAndHashCode(exclude = {"id", "name"})
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class ActivityType {
    
    @Id
    @GeneratedValue
    @JsonView({Activity.View.List.class})
    private Long id;
    
    @Column
    @JsonView({Activity.View.List.class})
    private String name;
    
    @Column
    @JsonView({Activity.View.List.class})
    private String description;
    
    @OneToMany(mappedBy = "type")
    @JsonIgnore
    private Set<Activity> activities;
}
