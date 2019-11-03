package com.vuchobe.api.model.v2;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Singular;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity(name = "lesson")
@Data
@NoArgsConstructor
public class Lesson {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column(unique = true, nullable = false)
    private String fullname;

    @Column(unique = true, nullable = false)
    private String shortname;

    @ManyToMany(mappedBy = "lessons")
    private Set<Timetable> timetables = new HashSet<>();

    @Singular
    @OneToMany(mappedBy = "lesson")
    private Set<StudentMark> studentMarks;

}
