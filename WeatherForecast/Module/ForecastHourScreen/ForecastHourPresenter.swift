//
//  ForecastHourPresenter.swift
//  Test
//
//  Created by Sergey Starchenkov on 25.06.2021.
//

import Foundation

protocol IForecastHourPresenter: AnyObject
{
    func viewDidLoad(view: IForecastHourViewController)
    func numberOfRows() -> Int
    func configureCell(cell: ForecastHourTableViewCell, indexPath: IndexPath)
    func forecastHourDidLoad(forecast: [ForecastHourEntity])
    func didTapClose()
}

final class ForecastHourPresenter
{
    private weak var view: IForecastHourViewController?
    private let router: IForecastHourRouter
    private let interactor: IForecastHourInteractor
    private var forecastHour = [ForecastHourEntity]()
    private let selectedUID: String
    
    init(uid: String, router: IForecastHourRouter, interactor: IForecastHourInteractor) {
        self.selectedUID = uid
        self.router = router
        self.interactor = interactor
    }
}

extension ForecastHourPresenter: IForecastHourPresenter
{
    func viewDidLoad(view: IForecastHourViewController) {
        self.view = view
        self.displayHourForecast(uid: self.selectedUID)
    }
    
    func numberOfRows() -> Int {
        return self.forecastHour.count
    }
    
    func configureCell(cell: ForecastHourTableViewCell, indexPath: IndexPath) {
        cell.set(forecast: self.forecastHour[indexPath.row])
    }
    
    func forecastHourDidLoad(forecast: [ForecastHourEntity]) {
        DispatchQueue.main.async {
            self.forecastHour = forecast
            self.view?.updateUI()
        }
    }
    
    func didTapClose() {
        self.router.close()
    }
}

private extension ForecastHourPresenter
{
    private func displayHourForecast(uid: String) {
        self.interactor.getHourForecast(uid: uid)
    }
}
