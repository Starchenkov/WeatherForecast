//
//  WeatherEntity.swift
//  Test
//
//  Created by Sergey Starchenkov on 25.06.2021.
//

struct WeatherEntity
{
    let date: String
    let temp: Int
    let icon: String
    let hours: [Hours]
    
    init(date: String, temp: Int, icon: String, hours: [Hours]) {
        self.date = date
        self.temp = temp
        self.icon = icon
        self.hours = hours
    }
}
