//
//  SingleTon.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 02/11/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import Foundation

final class SingleTon{
    
    static let shared = SingleTon()
    private init(){
    }
    
    var timeTable = [TimeTableJSON]()
    
}
