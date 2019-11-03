package com.vuchobe.api.json;

import com.vuchobe.api.model.Recommendation;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class RecommendationJson {

    private Long id;

    @DateTimeFormat(pattern = "YYYY-dd-MMThh:mm")
    private LocalDateTime startDate;

    private String address;

    private String organizer;

    private LessonJson lesson;

    private MarkJson mark;

    public RecommendationJson() {
    }

    public RecommendationJson(Recommendation recommendation) {
        this.id = recommendation.getId();
        this.startDate = recommendation.getStartDate();
        this.address = recommendation.getAddress();
        this.organizer = recommendation.getOrganizer();
        this.lesson = new LessonJson(recommendation.getLesson());
        this.mark = new MarkJson(recommendation.getMark());
    }

    public static List<RecommendationJson> createCollections(Collection<Recommendation> entity) {
        List<RecommendationJson> list = new ArrayList<>(entity.size());

        entity.forEach(item -> list.add(new RecommendationJson(item)));

        return list;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOrganizer() {
        return organizer;
    }

    public void setOrganizer(String organizer) {
        this.organizer = organizer;
    }

    public LessonJson getLesson() {
        return lesson;
    }

    public void setLesson(LessonJson lesson) {
        this.lesson = lesson;
    }

    public MarkJson getMark() {
        return mark;
    }

    public void setMark(MarkJson mark) {
        this.mark = mark;
    }
}
