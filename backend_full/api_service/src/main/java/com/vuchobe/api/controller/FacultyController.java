package com.vuchobe.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.json.JsonPage;
import com.vuchobe.api.model.v2.Faculty;
import com.vuchobe.api.service.FacultyService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/faculty")
@AllArgsConstructor
public class FacultyController {

    private final FacultyService facultyService;

    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public Long save(@JsonView(Faculty.View.Save.class) @RequestBody Faculty faculty) {
        return facultyService.save(faculty).getId();
    }

    @PutMapping("")
    @ResponseStatus(HttpStatus.OK)
    public Long update(@JsonView(Faculty.View.Update.class) @RequestBody Faculty institute) {
        return facultyService.update(institute).getId();
    }

    @GetMapping("")
    @JsonView(Faculty.View.List.class)
    public Page<Faculty> get(Pageable pageable) {
        return new JsonPage<>(facultyService.get(pageable));
    }

    @GetMapping("/institute/{instituteId}")
    @JsonView(Faculty.View.List.class)
    public Page<Faculty> get(@PathVariable Long instituteId,  Pageable pageable) {
        return new JsonPage<>(facultyService.getByInstituteId(instituteId, pageable));
    }

}
