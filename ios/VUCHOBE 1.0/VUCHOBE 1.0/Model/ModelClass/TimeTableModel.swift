//
//  TimeTableModel.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 02/11/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import Foundation

class TimeTableJSON: Codable{
    var result: [Weak]?
    var total: Int?
    init(
        result: [Weak]?,
        total: Int
    ){
        self.result = result
        self.total = total
    }
}

class Weak :Codable{
    var mondayDay: [AcademicHour]?
    var tuesdayDay: [AcademicHour]?
    var wednesdayDay: [AcademicHour]?
    var thursdayDay: [AcademicHour]?
    var fridayDay: [AcademicHour]?
    var saturdayDay: [AcademicHour]?
    
    init(
        mondayDay: [AcademicHour]?,
        tuesdayDay: [AcademicHour]?,
        wednesdayDay: [AcademicHour]?,
        thursdayDay: [AcademicHour]?,
        fridayDay: [AcademicHour]?,
        saturdayDay: [AcademicHour]?
    ){
        self.mondayDay = mondayDay
        self.tuesdayDay = tuesdayDay
        self.wednesdayDay = wednesdayDay
        self.thursdayDay = thursdayDay
        self.fridayDay = fridayDay
        self.saturdayDay = saturdayDay
    }
}

class AcademicHour: Codable{
    var lesson: String?
    var teacher: String?
    var timeBegin: String?
    var timeEnd: String?
    var roomNumber: String?
    var cellColor: String?
    
    init(
         lesson: String,
         teacher: String?,
         timeBegin: String?,
         timeEnd: String?,
         roomNumber: String?,
         cellColor: String?
    ){
        self.lesson = lesson
        self.teacher = teacher
        self.timeBegin = timeBegin
        self.timeEnd = timeEnd
        self.roomNumber = roomNumber
        self.cellColor = cellColor
    }
}

