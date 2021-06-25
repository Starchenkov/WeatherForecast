//
//  ForecastDayInteractor.swift
//  Test
//
//  Created by Sergey Starchenkov on 23.06.2021.
//

protocol IForecastDayInteractor: AnyObject
{
    func getWeatherForecast()
}

class ForecastDayInteractor
{
    private let dataManager: IDataStorage
    private let networkManager: INetworkManager
    weak var presenter: IForecastDayPresenter? = nil
    
    init(dataManager: IDataStorage, networkManager: INetworkManager) {
        self.networkManager = networkManager
        self.dataManager = dataManager
    }
}

extension ForecastDayInteractor: IForecastDayInteractor
{
    func getWeatherForecast() {
        self.loadForecastsFromDB()
        self.fetchForecastsFromAPI()
    }
}

private extension ForecastDayInteractor
{
    private func loadForecastsFromDB() {
        let forecast = self.dataManager.loadDayForecasts()
        if forecast.count != 0 {
            self.presenter?.weatherDidFetch(forecast: forecast)
        }
    }
    
    private func fetchForecastsFromAPI() {
        networkManager.fetchWeatherData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let forecast = self.convertWeatherResponseToEntity(response: response)
                print("успешно получили данные из сети")
                // При успешном получении данных из сети считаем что они обновленные (отсутствует поле даты изменения)
                self.dataManager.saveForecast(with: forecast) {
                    self.loadForecastsFromDB()
                }
                return
            case .failure( _):
                self.presenter?.showAlert()
            }
        }
    }
    
    private func convertWeatherResponseToEntity(response: WeatherApiResponse) -> [WeatherEntity] {
        let forecast = response.forecasts.map { WeatherEntity(date: $0.date,
                                                              temp: $0.parts.day.temp_avg,
                                                              icon: $0.parts.day.icon,
                                                              hours: $0.hours)}
        return forecast
    }
}
