package com.vuchobe.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.form.StudentForm;
import com.vuchobe.api.json.JsonPage;
import com.vuchobe.api.model.v2.Activity;
import com.vuchobe.api.model.v2.ActivityType;
import com.vuchobe.api.model.v2.Student;
import com.vuchobe.api.model.v2.UserAuthEntity;
import com.vuchobe.api.service.ActivityService;
import com.vuchobe.api.service.StudentService;
import com.vuchobe.auth.model.UserSecurity;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/student")
@AllArgsConstructor
public class StudentController {
    private final StudentService studentService;

    @PutMapping("")
    @ResponseStatus(HttpStatus.OK)
    public Long update(@RequestBody StudentForm studentForm, @AuthenticationPrincipal UserSecurity userAuthEntity) {
        Student student = studentForm.convertToEntity();
        student.setId(userAuthEntity.getStudentId());
        return studentService.update(student).getId();
    }
    
    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    @JsonView(Student.View.One.class)
    public Student get(@PathVariable("id")Long id, @AuthenticationPrincipal UserSecurity userAuthEntity) {
        return studentService.getById(userAuthEntity.getStudentId());
    }

/*    @GetMapping("")
    @JsonView(Student.View.List.class)
    public Page<Student> get(Pageable pageable) {
        return new JsonPage<>(activityService.get(pageable));
    }*/
    
}
