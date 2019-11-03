package com.vuchobe.api.json;


import com.vuchobe.api.model.Mark;

public class MarkJson {
    private Long id;

    private Integer value;

    public MarkJson() {
    }

    public MarkJson(Mark mark) {
        this.id = mark.getId();
        this.value = mark.getValue();
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
}
