package com.vuchobe.api.model.v2;

import com.vuchobe.api.json.UserBody;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name = "organization_user")
@Data
@NoArgsConstructor
public class OrganizationUser implements UserSystem {

    @Id
    @GeneratedValue
    private Long id;

    @OneToOne
    @JoinColumn(name = "person_id", nullable = false)
    private Person person;

    @ManyToOne
    @JoinColumn(name = "organization_id")
    private Organization organization;

    public OrganizationUser(UserBody userBody) {
        Person person = new Person(userBody.getLastName(), userBody.getFirstName(), userBody.getSecondName());
        UserAuthEntity authEntity = new UserAuthEntity(userBody.getEmail(), userBody.getUsername(), userBody.getPassword(), person);
        person.setUser(authEntity);
        this.person = person;
    }
}
