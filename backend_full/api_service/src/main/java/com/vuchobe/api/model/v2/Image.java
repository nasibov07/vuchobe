package com.vuchobe.api.model.v2;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import sun.misc.BASE64Decoder;

import javax.imageio.ImageIO;
import javax.persistence.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;

@Entity(name = "image")
@Data
@NoArgsConstructor
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class Image {

    @Id
    @GeneratedValue
    private Long id;

    @Column
    private byte[] bytes;

    @Column
    private String type;

    @Column
    private String name;

    @ManyToOne
    @JoinColumn(name = "activity_id")
    @JsonIdentityReference(alwaysAsId = true)
    @ToString.Exclude
    private Activity activity;

    public Image(String base64) {
        String[] formatBase64 = base64.split(",", 2);
        String typeImg = formatBase64[0].replace("data:", "")
                .replace(";base64", "");
        String imgBase64 = formatBase64[1];
        BASE64Decoder decoder = new BASE64Decoder();
        try {
            this.bytes = decoder.decodeBuffer(imgBase64);
            this.type = typeImg;
        } catch (Exception ex) {
            throw new RuntimeException("Не смог сконвертировать изображение...Проверти изображение");
        }


    }
}
