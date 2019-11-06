//
//  ModelClass.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 27/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import Foundation

class ModelClass: Codable{
    var content:[ModelClassContent]?
    var totalElements: Int?
    init(content:[ModelClassContent]?,totalElements: Int?){
        self.content = content
        self.totalElements = totalElements
    }
}

class ModelClassContent: Codable{
    var id: Int?
    var name: String?
    var type: String?
    var description: String?
    var fullName: String?
    var shortName: String?
    
    var address: Address?
    //var images: [String]?
    
    init(id: Int?, name: String?, type: String?, description: String?, fullName: String?, shortName: String?, address: Address?){//, images: [String]?
        self.id = id
        self.name = name
        self.type = type
        self.description = description
        self.fullName = fullName
        self.shortName = shortName
        self.address = address
        //self.images = images
        
    }
}

class Address: Codable {
    var fullAddress: String?
    
    init(fullAddress: String?){
        self.fullAddress = fullAddress
    }
}
