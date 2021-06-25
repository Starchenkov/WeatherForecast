//
//  Forecast.swift
//  Test
//
//  Created by Sergey Starchenkov on 24.06.2021.
//

import Foundation
import RealmSwift

final class ForecastDayObject: Object
{
    @objc dynamic var uid = UUID()
    @objc dynamic var date: String = ""
    @objc dynamic var temp: Int = 0
    @objc dynamic var icon: String = ""
    let hours = List<ForecastHourObject>()
    
    convenience init(date: String, temp: Int, icon: String) {
        self.init()
        self.uid = UUID()
        self.date = date
        self.temp = temp
        self.icon = icon
    }
}
