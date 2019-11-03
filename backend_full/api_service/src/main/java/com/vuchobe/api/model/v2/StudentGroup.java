package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.vuchobe.api.views.Views;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "student_group")
@Data
@NoArgsConstructor
public class StudentGroup {

    @Id
    @GeneratedValue
    @JsonView({View.Update.class, View.List.class})
    private Long id;

    @Column
    @JsonView({View.Save.class, View.List.class})
    private String name;

    @Column(name = "create_year")
    @JsonView({View.Save.class, View.List.class})
    private Integer year;

    @ManyToMany
    @JoinTable(name = "student_group_to_student",
            joinColumns = @JoinColumn(name = "student_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "student_group_id", referencedColumnName = "id")
    )
    private Set<Student> students = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "faculty_id", nullable = false)
    @JsonView({View.List.class})
    @JsonIdentityInfo(
            scope = StudentGroup.class,
            generator = ObjectIdGenerators.PropertyGenerator.class,
            property = "id")
    @JsonIdentityReference(alwaysAsId = true)
    private Faculty faculty;

    @OneToMany(mappedBy = "studentGroup")
    @JsonIdentityInfo(
            scope = StudentGroup.class,
            generator = ObjectIdGenerators.PropertyGenerator.class,
            property = "id")
    @JsonIdentityReference(alwaysAsId = true)
    @JsonView(Views.Default.class)
    private Set<Timetable> timetables = new HashSet<>();

    @Transient
    @JsonView({View.Save.class})
    private Long facultyId;
    
    public void updateEntity(StudentGroup newEntity) {
        this.name = newEntity.name;
        this.year = newEntity.year;
    }
    
    public static class View {
        public static class Save {};

        public static class Update extends Save {};

        public static class List extends Views.List {};
    }
}
