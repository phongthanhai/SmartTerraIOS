//
//  WaterData.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 27/12/2024.
//

import Foundation

class WaterSchedule{
    let date: String
    let startTime: String
    let endTime: String
    
    init(date: String, startTime: String, endTime: String) {
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
    }
    
}

let fetchedWaterSchedules: [WaterSchedule] = [
    WaterSchedule(date:"1 Dec 2024", startTime: "8:30AM", endTime: "9:30AM"),
    WaterSchedule(date:"2 Dec 2024", startTime: "11:30AM", endTime: "12:30AM"),
    WaterSchedule(date:"3 Dec 2024", startTime: "12:30AM", endTime: "3:30AM"),
    
]
