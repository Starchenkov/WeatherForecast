//
//  ForecastDayEntity.swift
//  Test
//
//  Created by Sergey Starchenkov on 23.06.2021.
//

import Foundation

struct ForecastDayEntity
{
    let uid: UUID
    let date: String
    let temp: Int
    let icon: String
    
    init(uid: UUID, date: String, temp: Int, icon: String) {
        self.uid = uid
        self.date = date
        self.temp = temp
        self.icon = icon
    }
}
