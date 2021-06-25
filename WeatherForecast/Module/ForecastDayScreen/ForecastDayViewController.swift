//
//  ForecastDayViewController.swift
//  Test
//
//  Created by Sergey Starchenkov on 23.06.2021.
//

import UIKit
import SnapKit

protocol IForecastDayViewController: AnyObject
{
    func updateUI()
    func showAlert(message: String)
}

final class ForecastDayViewController: UIViewController
{
    let presenter: IForecastDayPresenter
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ForecastDayTableViewCell.self, forCellReuseIdentifier: ForecastDayTableViewCell.identifier)
        return tableView
    }()
    
    init(presenter: IForecastDayPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.addConstraints()
        self.configureTableView()
        self.presenter.viewDidLoad(view: self)
    }
}

private extension ForecastDayViewController
{
    private func addSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    private func addConstraints() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension ForecastDayViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastDayTableViewCell.identifier, for: indexPath) as? ForecastDayTableViewCell else { return UITableViewCell() }
        self.presenter.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didTapForecast(indexPath: indexPath)
    }
}

extension ForecastDayViewController: IForecastDayViewController
{
    func updateUI() {
        self.tableView.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertNetworkErrorTitle, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: Constants.alertActionTextOK, style: .default, handler:  nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
    }
}
