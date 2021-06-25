//
//  ForecastHourEntity.swift
//  Test
//
//  Created by Sergey Starchenkov on 25.06.2021.
//

struct ForecastHourEntity
{
    let hour: String
    let temp: Int
    let icon: String
    
    init(hour: String, temp: Int, icon: String) {
        self.hour = hour
        self.temp = temp
        self.icon = icon
    }
}
