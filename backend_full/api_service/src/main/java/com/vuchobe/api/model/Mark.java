package com.vuchobe.api.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

//@Entity
//@Table(name = "mark")
public class Mark {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @Column
    private Integer value;

    @OneToMany(mappedBy = "mark")
    private Set<Rating> ratings = new HashSet<>();

    @OneToMany(mappedBy = "mark")
    private Set<Recommendation> recommendations = new HashSet<>();

    public Mark() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    public Set<Rating> getRatings() {
        return ratings;
    }

    public void setRatings(Set<Rating> ratings) {
        this.ratings = ratings;
    }

    public Set<Recommendation> getRecommendations() {
        return recommendations;
    }

    public void setRecommendations(Set<Recommendation> recommendations) {
        this.recommendations = recommendations;
    }
}
