package com.vuchobe.api.form;

import com.vuchobe.api.model.v2.Person;
import com.vuchobe.api.model.v2.Student;
import com.vuchobe.api.model.v2.StudentGroup;
import com.vuchobe.api.model.v2.UserAuthEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StudentForm {
    
    private String studentNumber;
    private Set<StudentGroup> studentGroup;
    
    private String lastName;
    private String firstName;
    private String secondName;


    private String username;

    private String email;

    private String password;
    
    public Student convertToEntity () {
        // if (studentGroup == null) throw new NullPointerException("student id is not found");
        Student student = new Student();
        if (studentGroup != null) {
            student.setStudentGroup(studentGroup);    
        }  
        
        student.setStudentNumber(studentNumber);
        
        Person person = new Person();
        person.setFirstName(firstName);
        person.setLastName(lastName);
        person.setSecondName(secondName);
        
        UserAuthEntity auth = new UserAuthEntity();
        if (email != null) auth.setEmail(email);
        if (username != null) auth.setUsername(username);
        if (password != null) auth.setPassword(password);
        
        person.setUser(auth);
        student.setPerson(person);
        
        return student;
    }
    
}
