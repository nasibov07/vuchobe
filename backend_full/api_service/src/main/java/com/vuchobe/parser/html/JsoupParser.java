package com.vuchobe.parser.html;

import com.vuchobe.api.model.Address;
import com.vuchobe.api.model.HighSchool;
import com.vuchobe.api.model.v2.Faculty;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Configuration
public class JsoupParser {

/*    public static void main(String[] args) {
        JsoupParser js = new JsoupParser();

        js.createVuz();
    }*/

    public List<HighSchool> createVuz() {
        List<HighSchool> schoolStream = new ArrayList<>();
        Document doc = null;
        try {
            doc = Jsoup.connect("http://vuz.edunetwork.ru/63/43/").get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Elements container = doc.getElementsByClass("unit");

        container.forEach(el ->
                {
                    el.getElementsByClass("unit-name")
                            .forEach(el1 -> {
                                el1.getElementsByTag("a")
                                        .forEach(el2 -> {
                                            // tagsA.add(el2);
                                            //texts.add(el2.text());
                                            HighSchool highSchool = new HighSchool(el2.text());
                                            createFaculty(el2, highSchool);
                                            schoolStream.add(highSchool);
                                        });
                            });
                }
        );

        return schoolStream;
    }

    public void createFaculty(Element el, HighSchool highSchool) {

        Document doc = null;
        try {
            doc = Jsoup.connect("http://vuz.edunetwork.ru/" + el.attr("href") + "/specs/").get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        doc.getElementsByClass("subunit").forEach(unit -> {
            Faculty faculty = new Faculty();

            String facultyName = unit.getElementsByTag("h2").get(0).text();//Name faculty

            Address address = new Address();
            String addressName = unit.getElementsByTag("p").get(0).text().replace("place", "");
            address.setName(addressName);
//
//                 faculty.setVyz(highSchool);
//                 faculty.setName(facultyName);
//                 faculty.setAddress(address);
//                 highSchool.getFaculties().add(faculty);
        });
    }
}
