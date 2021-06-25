//
//  HoursObject.swift
//  Test
//
//  Created by Sergey Starchenkov on 24.06.2021.
//

import Foundation
import RealmSwift

final class ForecastHourObject: Object
{
    @objc dynamic var hour: String = ""
    @objc dynamic var temp: Int = 0
    @objc dynamic var icon: String = ""
    var parentForecast = LinkingObjects(fromType: ForecastDayObject.self, property: "hours")
    
    convenience init(hour: String, temp: Int, icon: String) {
        self.init()
        self.hour = hour
        self.temp = temp
        self.icon = icon
    }
}
