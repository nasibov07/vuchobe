package com.vuchobe.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.json.JsonPage;
import com.vuchobe.api.model.v2.Institute;
import com.vuchobe.api.service.InstituteService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/institute")
@AllArgsConstructor
public class InstituteController {

    private InstituteService instituteService;

    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public Long save(@JsonView(Institute.View.Save.class) @RequestBody Institute institute) {
        return instituteService.save(institute).getId();
    }

    @PutMapping("")
    @ResponseStatus(HttpStatus.OK)
    public Long update(@JsonView(Institute.View.Update.class) @RequestBody Institute institute) {
        return instituteService.update(institute).getId();
    }

    @GetMapping("")
    @JsonView(Institute.View.List.class)
    public Page<Institute> get(Pageable pageable) {
        return new JsonPage<>(instituteService.get(pageable));
    }
}
