//
//  ForecastDayRouter.swift
//  Test
//
//  Created by Sergey Starchenkov on 23.06.2021.
//

import UIKit

protocol IForecastDayRouter
{
    func showForecastHour(with selectedDayUID: String)
}

class ForecastDayRouter: IForecastDayRouter
{
    var controller: UIViewController?
    
    func showForecastHour(with selectedDayUID: String) {
        let controller = ForecastHourAssembly.build(uid: selectedDayUID)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .fullScreen
        self.controller?.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
