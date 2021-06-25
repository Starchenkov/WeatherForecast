//
//  DataStorage.swift
//  Test
//
//  Created by Sergey Starchenkov on 24.06.2021.
//
import Foundation
import RealmSwift

protocol IDataStorage
{
    func saveForecast(with forecasts: [WeatherEntity], completion: @escaping () -> Void)
    func loadDayForecasts() -> [ForecastDayEntity]
    func loadHourForecasts(uid: String) -> [ForecastHourEntity]
}

final class DataStorage
{
    private init() {}
    static let instance = DataStorage()
    
    lazy var realm: Realm = {
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        return try! Realm()
    }()
}

extension DataStorage: IDataStorage
{
    func saveForecast(with forecasts: [WeatherEntity], completion: @escaping () -> Void) {
        self.deleteObject()
        
        for forecast in forecasts {
            let newForecastDayObject = ForecastDayObject(date: forecast.date,
                                                         temp: forecast.temp,
                                                         icon: forecast.icon)
            do {
                try self.realm.write {
                    self.realm.add(newForecastDayObject)
                }
            } catch {
                print("ошибка сохранения прогноза")
            }
            
            for hour in forecast.hours {
                do {
                    try self.realm.write {
                        let newForecastHour = ForecastHourObject(hour: hour.hour,
                                                                 temp: hour.temp,
                                                                 icon: hour.icon)
                        newForecastDayObject.hours.append(newForecastHour)
                    }
                } catch {
                    print("ошибка сохранения обьекта часового прогноза")
                }
            }
        }
        print("успешно записали новые данные")
        DispatchQueue.main.async { completion() }
    }
    
    func loadDayForecasts() -> [ForecastDayEntity] {
        let forecastsDB = self.realm.objects(ForecastDayObject.self)
        
        var forecastsDays = [ForecastDayEntity]()
        for forecast in forecastsDB {
            let item = ForecastDayEntity(uid: forecast.uid,
                                         date: forecast.date,
                                         temp: forecast.temp,
                                         icon: forecast.icon)
            forecastsDays.append(item)
        }
        return forecastsDays
    }
    
    func loadHourForecasts(uid: String) -> [ForecastHourEntity] {
        var forecastsHour = [ForecastHourEntity]()
        
        if let forecastsDB = self.realm.objects(ForecastDayObject.self).filter("uid == %@", uid).first {
            let forecastHourRaw = forecastsDB.hours
            for forecast in forecastHourRaw {
                let item = ForecastHourEntity(hour: forecast.hour,
                                              temp: forecast.temp,
                                              icon: forecast.icon)
                forecastsHour.append(item)
            }
        }
        return forecastsHour
    }
}

private extension DataStorage
{
    private func deleteObject() {
        let resultDay = self.realm.objects(ForecastDayObject.self)
        let resultHour = self.realm.objects(ForecastHourObject.self)
        do {
            try self.realm.write {
                self.realm.delete(resultDay)
                self.realm.delete(resultHour)
                print("успешно удалили старые данные")
            }
        } catch {
            print("ошибка удаления")
        }
    }
}
