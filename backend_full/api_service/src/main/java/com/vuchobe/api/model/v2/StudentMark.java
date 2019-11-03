package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.io.Serializable;

@Data
@Entity(name = "student_mark_lesson")
@JsonIdentityInfo(
        scope = StudentMark.class,
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "mark")
public class StudentMark implements Serializable {

    @Id
    @ManyToOne
    @JoinColumn(name = "mark_id")
    private Mark mark;

    @Id
    @ManyToOne
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;

    @Id
    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;


}


