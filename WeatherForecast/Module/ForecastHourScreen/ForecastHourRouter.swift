//
//  ForecastHourRouter.swift
//  Test
//
//  Created by Sergey Starchenkov on 25.06.2021.
//

import UIKit

protocol IForecastHourRouter
{
    func close()
}

final class ForecastHourRouter: IForecastHourRouter
{
    var controller: UIViewController?
    
    func close() {
        self.controller?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
