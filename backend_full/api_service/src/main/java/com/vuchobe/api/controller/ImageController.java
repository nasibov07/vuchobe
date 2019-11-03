package com.vuchobe.api.controller;

import com.vuchobe.api.dao.ImageDao;
import com.vuchobe.api.model.v2.Image;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/image")
@RestController
@AllArgsConstructor
public class ImageController {
    
    private ImageDao imageDao;
    
    @GetMapping("/{id}")
    public ResponseEntity<byte[]> get (@PathVariable("id") Long id) {
        Image img = imageDao.getOne(id);
        return ResponseEntity.status(HttpStatus.OK)
                .contentType(MediaType.parseMediaType(img.getType()))
                // .contentLength(img.getContent().length)
                .body(img.getBytes());
    }
}
