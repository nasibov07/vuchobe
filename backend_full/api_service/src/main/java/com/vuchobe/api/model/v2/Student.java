package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonView;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.vuchobe.api.json.UserBody;
import com.vuchobe.api.views.Views;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Singular;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "student")
@Data
@NoArgsConstructor
public class Student implements UserSystem, Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @JsonView({View.Update.class, View.List.class, View.One.class})
    private Long id;

    @Column
    @JsonView({View.Save.class, View.List.class, View.One.class})
    private String studentNumber;

    @OneToOne
    @JoinColumn(name = "person_id", nullable = false)
    @JsonView({View.Save.class, View.List.class, View.One.class})
    private Person person;

    @ManyToMany
    @JoinTable(name = "student_group_to_student",
            joinColumns = @JoinColumn(name = "student_group_id", referencedColumnName = "id", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "student_id", referencedColumnName = "id", nullable = false)
    )
    @JsonIdentityInfo(
            scope = Student.class,
            generator = ObjectIdGenerators.PropertyGenerator.class,
            property = "id")
    @JsonIdentityReference(alwaysAsId = true)
    @JsonView(View.One.class)
    private Set<StudentGroup> studentGroup = new HashSet<>();

    @Singular
    @OneToMany(mappedBy = "student")
    @JsonView(View.One.class)
    @JsonIdentityReference(alwaysAsId = true)
    private Set<StudentMark> studentMarks;

    public Student(UserBody userBody) {
        Person person = new Person(userBody.getLastName(), userBody.getFirstName(), userBody.getSecondName());
        UserAuthEntity authEntity = new UserAuthEntity(userBody.getEmail(), userBody.getUsername(), userBody.getPassword(), person);
        person.setUser(authEntity);
        this.person = person;
    }

    public void updateEntity(Student newEntity) {
        Person newPerson = newEntity.person;
        this.studentNumber = newEntity.studentNumber;
        if (newPerson != null) {

            if (newPerson.getLastName() != null) this.person.setLastName(newPerson.getLastName());
            if (newPerson.getFirstName() != null) this.person.setFirstName(newPerson.getFirstName());
            if (newPerson.getSecondName() != null) this.person.setSecondName(newPerson.getSecondName());

            UserAuthEntity newUserAuth = newPerson.getUser();
            if (newUserAuth != null) {
                UserAuthEntity oldEntity = person.getUser();
                if (newUserAuth.getEmail() != null) oldEntity.setEmail(newUserAuth.getEmail());
                if (newUserAuth.getUsername() != null) oldEntity.setUsername(newUserAuth.getUsername());
                if (newUserAuth.getPassword() != null) oldEntity.setPassword(newUserAuth.getPassword());
            }
            
        }
        if (newEntity.studentGroup != null) {
            this.studentGroup = newEntity.studentGroup;
        }
    }


    public static class View {
        public static class Save {};

        public static class Update extends Activity.View.Save {};

        public static class List extends Views.List {};
        
        public static class One{};
    }
}
