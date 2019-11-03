package com.vuchobe.api.controller;

import com.fasterxml.jackson.annotation.JsonView;
import com.vuchobe.api.json.JsonPage;
import com.vuchobe.api.model.v2.Activity;
import com.vuchobe.api.model.v2.ActivityType;
import com.vuchobe.api.service.ActivityService;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/activity")
@AllArgsConstructor
public class ActivityController {
    private final ActivityService activityService;
    
    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public Long save(@JsonView(Activity.View.Save.class) @RequestBody Activity activity) {
        return activityService.save(activity).getId();
    }

    @PutMapping("")
    @ResponseStatus(HttpStatus.OK)
    public Long update(@JsonView(Activity.View.Update.class) @RequestBody Activity institute) {
        return activityService.update(institute).getId();
    }

    @GetMapping("")
    @JsonView(Activity.View.List.class)
    public Page<Activity> get(Pageable pageable) {
        return new JsonPage<>(activityService.get(pageable));
    }
    
    
    @GetMapping("/type")
    public Page<ActivityType> getType(Pageable pageable) {
        return new JsonPage<>(activityService.getType(pageable));
    }    
    
    @PostMapping("/type")
    public Long saveType(@RequestBody ActivityType activityType) {
        return activityService.saveType(activityType).getId();
    }
    
    
}
