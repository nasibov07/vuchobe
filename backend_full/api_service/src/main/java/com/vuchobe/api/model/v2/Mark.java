package com.vuchobe.api.model.v2;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Singular;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
public class Mark {
    @Id
    private Long id;

    @Column(name = "value", unique = true, nullable = false, updatable = false, length = 8)
    private MarkEnum value;

    @Singular
    @OneToMany(mappedBy = "mark")
    private Set<StudentMark> studentMarks;

    @AllArgsConstructor
    public enum MarkEnum {
        EMPTY(0),
        ONE(1),
        TWO(2),
        FREE(3),
        FOUR(4),
        FIVE(5);

        int value;


    }
}
