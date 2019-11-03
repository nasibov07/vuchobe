package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.*;
import com.vuchobe.api.views.Views;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;


@Entity
@Table(name = "faculty")
@Data
@NoArgsConstructor
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Faculty {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @JsonView({View.Update.class, View.List.class, Institute.View.List.class})
    private Long id;

    @Column
    @JsonView({View.Save.class, View.List.class})
    private String fullName;

    @Column
    @JsonView({View.Save.class, View.List.class})
    private String shortName;

    @ManyToOne
    @JoinColumn(name = "institute_id", nullable = false)
    @JsonView({Faculty.View.List.class})
    @JsonIdentityReference(alwaysAsId = true)
    private Institute institute;

    @OneToMany(mappedBy = "faculty")
    @JsonIdentityReference(alwaysAsId = true)
    private Set<Timetable> timetables = new HashSet<>();

    @OneToOne
    @JoinColumn(name = "address_id")
    @JsonView({View.Save.class, View.List.class})
    private Address address;
    
    @Transient
    @JsonView({View.Save.class})
    private Long instituteId;
    
    public void updateEntity(Faculty newEntity) {
        this.fullName = newEntity.fullName;
        this.shortName = newEntity.shortName;
        if (newEntity.address != null) {
            this.address = newEntity.address;
        }
    }

    public static class View {
        public static class Save {};

        public static class Update extends Save{};

        public static class List extends Views.List {};
    }

}
