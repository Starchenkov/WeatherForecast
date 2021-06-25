//
//  ForecastHourInteractor.swift
//  Test
//
//  Created by Sergey Starchenkov on 25.06.2021.
//

protocol IForecastHourInteractor: AnyObject
{
    func getHourForecast(uid: String)
}

final class ForecastHourInteractor
{
    private let dataManager: IDataStorage
    weak var presenter: IForecastHourPresenter? = nil
    
    init(dataManager: IDataStorage) {
        self.dataManager = dataManager
    }
}

extension ForecastHourInteractor: IForecastHourInteractor
{
    func getHourForecast(uid: String) {
        self.loadHourForecastsFromDB(uid: uid)
    }
}

private extension ForecastHourInteractor
{
    private func loadHourForecastsFromDB(uid: String) {
        let hourForecast = self.dataManager.loadHourForecasts(uid: uid)
        if hourForecast.count != 0 {
            self.presenter?.forecastHourDidLoad(forecast: hourForecast)
        }
    }
}
