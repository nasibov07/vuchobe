package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.Activity;
import com.vuchobe.api.model.v2.ActivityType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ActivityTypeDao extends JpaRepository<ActivityType, Long> {
}
