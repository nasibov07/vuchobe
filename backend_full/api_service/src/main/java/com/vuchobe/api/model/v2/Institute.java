package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.vuchobe.api.views.Views;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Fetch;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

import static org.hibernate.annotations.FetchMode.SELECT;

@Entity
@Data
@NoArgsConstructor
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Institute {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @JsonView({View.Update.class, View.List.class})
    private Long id;

    @Column
    @JsonView({View.Save.class, View.List.class})
    private String fullName;

    @Column
    @JsonView({View.Save.class, View.List.class})
    private String shortName;

    @OneToMany(mappedBy = "institute")
    private Set<Faculty> faculties = new HashSet<>();

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "address_id")
    @JsonView({View.Save.class, View.List.class})
    private Address address;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    @JsonView({View.Save.class, View.List.class})
    private Organization organization;

    public static class View {
        public static class Save { };

        public static class Update extends Save { };

        public static class List extends Views.List { };
    }

    public void updateEntity(Institute newEntity) {
        this.fullName = newEntity.fullName;
        this.shortName = newEntity.shortName;
        if (newEntity.address != null) {
            this.address = newEntity.address;
        }
    }
}
