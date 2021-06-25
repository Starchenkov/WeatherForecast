//
//  ForecastDayPresenter.swift
//  Test
//
//  Created by Sergey Starchenkov on 23.06.2021.
//
import Foundation

protocol IForecastDayPresenter: AnyObject
{
    func viewDidLoad(view: IForecastDayViewController)
    func numberOfRows() -> Int
    func configureCell(cell: ForecastDayTableViewCell, indexPath: IndexPath)
    func didTapForecast(indexPath: IndexPath)
    func weatherDidFetch(forecast: [ForecastDayEntity])
    func showAlert()
}

class ForecastDayPresenter
{
    private weak var view: IForecastDayViewController?
    private let router: IForecastDayRouter
    private let interactor: IForecastDayInteractor
    private var forecastDays = [ForecastDayEntity]()
    
    init(router: IForecastDayRouter, interactor: IForecastDayInteractor) {
        self.router = router
        self.interactor = interactor
    }
}

extension ForecastDayPresenter: IForecastDayPresenter
{
    func didTapForecast(indexPath: IndexPath) {
        let selectedDate = self.forecastDays[indexPath.row].uid.uuidString
        self.router.showForecastHour(with: selectedDate)
    }
    
    func viewDidLoad(view: IForecastDayViewController) {
        self.view = view
        self.displayForecastDay()
    }
    
    func numberOfRows() -> Int {
        return self.forecastDays.count
    }
    
    func configureCell(cell: ForecastDayTableViewCell, indexPath: IndexPath) {
        cell.set(forecast: self.forecastDays[indexPath.row])
    }
    
    func weatherDidFetch(forecast: [ForecastDayEntity]) {
        DispatchQueue.main.async {
            self.forecastDays = forecast
            self.view?.updateUI()
            print("успешно обновляем UI интерфейс")
        }
    }
    
    func showAlert() {
        DispatchQueue.main.async {
            self.view?.showAlert(message: Constants.alertNetworkMessage)
        }
    }
}

extension ForecastDayPresenter
{
    private func displayForecastDay() {
        self.interactor.getWeatherForecast()
    }
}
