package com.vuchobe.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.json.JsonPage;
import com.vuchobe.api.model.v2.Faculty;
import com.vuchobe.api.model.v2.StudentGroup;
import com.vuchobe.api.service.StudentGroupService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

/*TODO Контролер для добавления институтов, факультетов,
 *
 * */
@RestController
@RequestMapping("/studentgroup")
@AllArgsConstructor
public class StudentGroupController {

    private final StudentGroupService studentgroupService;

    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public Long save(@JsonView(StudentGroup.View.Save.class) @RequestBody StudentGroup studentGroup) {
        return studentgroupService.save(studentGroup).getId();
    }

    @PutMapping("")
    @ResponseStatus(HttpStatus.OK)
    public Long update(@JsonView(StudentGroup.View.Update.class) @RequestBody StudentGroup studentGroup) {
        return studentgroupService.update(studentGroup).getId();
    }

    @GetMapping("")
    @JsonView(StudentGroup.View.List.class)
    public Page<StudentGroup> get(Pageable pageable) {
        return new JsonPage<>(studentgroupService.get(pageable));
    }

}
