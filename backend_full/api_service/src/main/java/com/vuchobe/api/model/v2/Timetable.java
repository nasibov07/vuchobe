package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.views.Views;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity(name = "timetable")
public class Timetable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @JsonView(Views.Default.class)
    private Long id;

    @Column(name = "start_lesson")
    @JsonView(Views.Default.class)
    private LocalDateTime start;

    @Column(name = "end_lesson")
    @JsonView(Views.Default.class)
    private LocalDateTime end;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonView(Views.Default.class)
    @JoinColumn(name = "faculty_id", nullable = false)
    private Faculty faculty;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonView(Views.Default.class)
    @JoinColumn(name = "student_group_id", nullable = false)
    private StudentGroup studentGroup;

    @ManyToMany
    @JoinTable(name = "timetable_to_lesson",
            joinColumns = @JoinColumn(name = "timetable_id"),
            inverseJoinColumns = @JoinColumn(name = "lesson_id")
    )
    @JsonView(Views.Default.class)
    private Set<Lesson> lessons = new HashSet<>();

    public Timetable() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getStart() {
        return start;
    }

    public void setStart(LocalDateTime start) {
        this.start = start;
    }

    public LocalDateTime getEnd() {
        return end;
    }

    public void setEnd(LocalDateTime end) {
        this.end = end;
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }

    public StudentGroup getStudentGroup() {
        return studentGroup;
    }

    public void setStudentGroup(StudentGroup studentGroup) {
        this.studentGroup = studentGroup;
    }

    public Set<Lesson> getLessons() {
        return lessons;
    }

    public void setLessons(Set<Lesson> lessons) {
        this.lessons = lessons;
    }
}
