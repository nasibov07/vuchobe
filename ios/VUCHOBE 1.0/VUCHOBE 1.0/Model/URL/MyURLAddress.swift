//
//  MyURLAddress.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 27/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import Foundation

class MyURLAddress{
    static let shared = MyURLAddress()
    private init(){
    }
    
    //MARK: Авторизация регистрация
    //URl на Авторизацию
    let UrlForAuthorization: String                     = "http://vuchobe.com/api/v1/auth/login"
    //URL на Регистрацию
    let UrlForRegistration:  String                     = "http://vuchobe.com/api/v1/auth/registration/STUDENT"
    
    
    //MARK: Рекомендации
    //URL адрес для получения рекомендации на главное окно
    let UrlForGettingRecommendation: String             = "http://vuchobe.com/api/v1/activity"
    //URL адрес для полчения данных для comboBox с типами рекомендации
    let UrlForGettingType: String                       = "http://vuchobe.com/api/v1/activity/type"
    //URL адрес для создания мероприятия
    let UrlForCreatRecommendation: String               = "http://vuchobe.com/api/v1/activity"
    //URL для получения мероприятия
    let UrlForShowRecommendation: String                = "http://vuchobe.com/api/v1/activity"
    
    //MARK: Профиль
    //URL для получение название факультета
    let UrlForGettingUniversityName: String             = "http://vuchobe.com/api/v1/faculty"
}
