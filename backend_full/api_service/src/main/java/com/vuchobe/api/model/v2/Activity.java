package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.vuchobe.api.views.Views;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;


import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Set;

@Entity(name = "activity")
@Data
@NoArgsConstructor
@EqualsAndHashCode(of = {"id", "name", "dateStart", "address"})
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Activity {
    
    @Id
    @GeneratedValue
    @JsonView({View.Update.class, View.List.class})
    private Long id;
    
    @Column(name = "date_start")
    private LocalDateTime dateStart;
    
    @ManyToOne()
    @JoinColumn(name = "address_id")
    private Address address;

    @Column
    @JsonView({View.Save.class, View.List.class})
    private String name;
    
    @ManyToOne()
    @JoinColumn(name = "type_id")
    @JsonView({View.Save.class, View.List.class})
    @JsonIdentityReference(alwaysAsId = true)
    private ActivityType type;
    
    @Column(length = 3500)
    @JsonView({View.Save.class, View.List.class})
    private String description;  
    
    @Column(length = 1500)
    @JsonView({View.Save.class, View.List.class})
    private String shortDescription;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "institute_id")
    @ToString.Exclude
    private Institute institute;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "organization_id")
    @ToString.Exclude
    private Organization organization;
    
    @OneToMany(mappedBy = "activity")
    @JsonView({View.List.class})
    @JsonIdentityReference(alwaysAsId = true)
    @ToString.Exclude
    private Set<Image> images;

    @ManyToMany(mappedBy = "activities")
    @ToString.Exclude
    private Set<Interest> interests;
    
    @Transient
    @JsonView({View.Save.class})
    private Long instituteId;
    
    @Transient
    @JsonView({View.Save.class})
    private Long organizationId;
    
    @Transient
    @JsonView({View.Save.class})
    private List<Long> typeIds;    
    
    @Transient
    @JsonView({View.Save.class})
    private Set<String> imagesBase64;

    public void updateEntity(Activity newEntity) {
        this.name = newEntity.name;
        this.description = newEntity.description;
        this.type = new ActivityType();
        if (this.typeIds.size() > 0) {
            this.type.setId(this.typeIds.get(0));
        }
    }
    
    public static class View {
        public static class Save {};

        public static class Update extends Save{};

        public static class List extends Views.List {};
    }
}
