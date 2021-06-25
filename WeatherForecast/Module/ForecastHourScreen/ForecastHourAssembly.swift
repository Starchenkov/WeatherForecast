//
//  ForecastHourAssembly.swift
//  Test
//
//  Created by Sergey Starchenkov on 25.06.2021.
//

import UIKit

final class ForecastHourAssembly
{
    static func build(uid: String) -> UIViewController {
        let router = ForecastHourRouter()
        let dataManager = DataStorage.instance
        let interactor = ForecastHourInteractor(dataManager: dataManager)
        let presenter = ForecastHourPresenter(uid: uid, router: router, interactor: interactor)
        interactor.presenter = presenter
        let controller = ForecastHourViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
