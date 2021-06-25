//
//  ForecastDayAssembly.swift
//  Test
//
//  Created by Sergey Starchenkov on 23.06.2021.
//

import UIKit

class ForecastDayAssembly
{
    static func build() -> UIViewController {
        let router = ForecastDayRouter()
        let networkManager = NetworkManager.instance
        let dataManager = DataStorage.instance
        let interactor = ForecastDayInteractor(dataManager: dataManager, networkManager: networkManager)
        let presenter = ForecastDayPresenter(router: router, interactor: interactor)
        interactor.presenter = presenter
        let controller = ForecastDayViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
