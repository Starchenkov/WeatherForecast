//
//  WeatherApiResponse.swift
//  Test
//
//  Created by Sergey Starchenkov on 24.06.2021.
//

struct WeatherApiResponse: Decodable {
    let forecasts: [Forecast]
}

struct Forecast: Decodable {
    let date: String
    let parts: Parts
    let hours: [Hours]
}

struct Hours: Decodable {
    let hour: String
    let temp: Int
    let icon: String
}

struct Parts: Decodable {
    let day: Day
}

struct Day: Decodable {
    let icon: String
    let temp_avg: Int
}
