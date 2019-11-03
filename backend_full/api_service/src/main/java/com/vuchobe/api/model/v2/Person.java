package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonView;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@NoArgsConstructor
@ToString(exclude = "user")
public class Person {

    @Id
    @GeneratedValue
    @JsonView(Student.View.One.class)
    private Long id;

    @Column(name = "lastName", length = 55)
    @JsonView(Student.View.One.class)
    private String lastName;

    @Column(name = "firstName", length = 55)
    @JsonView(Student.View.One.class)
    private String firstName;

    @Column(name = "secondName", length = 55)
    @JsonView(Student.View.One.class)
    private String secondName;

    @OneToOne(mappedBy = "man")
    private UserAuthEntity user;

    @OneToOne(mappedBy = "person")
    private Student student;

    @OneToOne(mappedBy = "person")
    private OrganizationUser organizationUser;

    @ManyToMany
    private Set<Interest> interests = new HashSet<>();


    public Person(String lastName, String firstName, String secondName) {
        this.lastName = lastName;
        this.firstName = firstName;
        this.secondName = secondName;
    }
}
