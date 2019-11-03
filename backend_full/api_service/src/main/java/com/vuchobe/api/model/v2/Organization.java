package com.vuchobe.api.model.v2;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Organization {

    @Id
    @GeneratedValue
    private Long id;

    @Column
    private String name;

    private OrganizationEnum type;
 
    @Column
    private Boolean isConfirm;

    @Column
    private String inn;

    @OneToMany(mappedBy = "organization")
    private Set<OrganizationUser> users = new HashSet<>();
    
    @OneToMany(mappedBy = "organization")
    private Set<Institute> institutes = new HashSet<>();

    public enum OrganizationEnum {
        INSTITUT("Институт"),
        ORGANIZATION("Организаторы мероприятий"),
        OTHER("Другие");

        private String value;

        OrganizationEnum(String value) {
            this.value = value;
        }
    }
    
}
