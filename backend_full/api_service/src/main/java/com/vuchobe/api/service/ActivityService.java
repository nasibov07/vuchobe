package com.vuchobe.api.service;

import com.vuchobe.api.dao.ActivityDao;
import com.vuchobe.api.dao.ActivityTypeDao;
import com.vuchobe.api.dao.ImageDao;
import com.vuchobe.api.dao.InstituteDao;
import com.vuchobe.api.model.v2.Activity;
import com.vuchobe.api.model.v2.ActivityType;
import com.vuchobe.api.model.v2.Image;
import com.vuchobe.api.model.v2.Institute;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

@Service
@AllArgsConstructor
@Transactional(readOnly = true)
public class ActivityService {

    private ActivityDao activityDao;
    private ActivityTypeDao activityTypeDao;
    private InstituteDao instituteDao;
    private ImageDao imageDao;


    @Transactional
    public Activity save(Activity activity) {
        if (activity.getInstituteId() == null && activity.getOrganizationId() == null)
            throw new NullPointerException("Укажите кто проводит меропртиятие");
        if (activity.getTypeIds() == null) throw new NullPointerException("Выберите тип мероприятия.");
        else  {
            ActivityType activityType = new ActivityType();
            if (activity.getTypeIds().size() > 0) {
                activityType.setId(activity.getTypeIds().get(0));
            }
            
            activity.setType(activityType);
        }
        if (activity.getInstituteId() != null) {
            Institute institute = instituteDao.findById(activity.getInstituteId())
                    .orElseThrow(() -> new NullPointerException("Институт с таким идентификатором не найден"));
            activity.setInstitute(institute);
        } else {
            throw new UnsupportedOperationException("Меропртия для организаций в данный момент не поддерживаются");
        }
        if (activity.getImagesBase64().size() > 0) {
            saveImagesToActivity(activity);
        } else {
            throw new NullPointerException("Прикрепите хотя бы 1 изображение");
        }
        return activityDao.save(activity);
    }

    @Transactional
    public Activity update(Activity activity) {
        Activity activity1Entity = activityDao.findById(activity.getId())
                .orElseThrow(() -> new NullPointerException("Мероприятие с таким идентификатором не найден"));
        activity1Entity.updateEntity(activity);
        if (activity.getImagesBase64().size() > 0) {
            saveImagesToActivity(activity);
        }
        return activityDao.save(activity1Entity);
    }

    private void saveImagesToActivity (Activity activity) {
        Set<Image> images = new HashSet<>();
        activity.getImagesBase64().forEach(image -> {
            Image imageEntity = new Image(image);
            imageEntity.setActivity(activity);
            images.add(imageEntity);
        });
        activity.setImages(images);
        imageDao.saveAll(images);
    }
    
    public Page<Activity> get(Pageable pageable) {
        return activityDao.findAll(pageable);
    }

    public Page<ActivityType> getType(Pageable pageable) {
        return activityTypeDao.findAll(pageable);
    }
    
    public ActivityType saveType(ActivityType activityType) {
        return activityTypeDao.save(activityType);
    }
}
