package com.vuchobe.api.dao;

import com.vuchobe.api.model.v2.Activity;
import com.vuchobe.api.model.v2.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageDao extends JpaRepository<Image, Long> {
}
