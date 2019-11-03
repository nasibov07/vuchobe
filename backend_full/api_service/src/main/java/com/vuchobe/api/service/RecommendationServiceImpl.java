package com.vuchobe.api.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(
        readOnly = true
)
public class RecommendationServiceImpl implements RecommendationService {
/*
    private final RecommendationDao recommendationDao;
    private final MarkDao markDao;
    private final LessonDao lessonDao;

    @Autowired
    public RecommendationServiceImpl(RecommendationDao recommendationDao, MarkDao markDao, LessonDao lessonDao) {
        this.recommendationDao = recommendationDao;
        this.markDao = markDao;
        this.lessonDao = lessonDao;
    }

    @Override
    public Page<RecommendationJson> findWithPagination(Pageable pageable) {
        Page<Recommendation> res = recommendationDao
                .findAll(
                        pageable
                );

        List<RecommendationJson> list  = RecommendationJson.createCollections(res.getContent());

        Page<RecommendationJson> recommendationJson = new PageImpl<RecommendationJson>(list,res.getPageable(),res.getTotalPages());
        return recommendationJson;
    }
    @Override
    public List<RecommendationJson> findAll() {
        return RecommendationJson.createCollections(
                recommendationDao.findAll()
        );
    }

    @Override
    @Transactional
    public Long save(Recommendation recommendation) {
        if(recommendation.getMark() != null) {
            Mark mark = markDao.findByValue(recommendation.getMark().getValue())
                    .orElse(recommendation.getMark());
            if (mark.getId() == null) {
                markDao.save(mark);
            }
            recommendation.setMark(mark);
        }

        if(recommendation.getLesson() != null) {
            Lesson lesson = lessonDao.findByNameIgnoreCase(recommendation.getLesson().getName())
                    .orElse(recommendation.getLesson());
            if (lesson.getId() == null) {
                lessonDao.save(lesson);
            }
            recommendation.setLesson(lesson);
        }
        recommendationDao.save(recommendation);

        return recommendation.getId();
    }

    @Override
    @Transactional
    public void delete(Long id) {
        Recommendation entity = recommendationDao.findById(id)
                .orElseThrow(NullPointerException::new);
        recommendationDao.delete(entity);
    }*/
}
