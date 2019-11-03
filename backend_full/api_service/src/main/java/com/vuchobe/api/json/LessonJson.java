package com.vuchobe.api.json;

import com.vuchobe.api.model.v2.Lesson;

public class LessonJson {

    private Long id;

    private String name;

    public LessonJson() {
    }

    public LessonJson(Lesson lesson) {
        this.id = lesson.getId();
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
}
