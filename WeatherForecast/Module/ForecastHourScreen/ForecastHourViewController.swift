//
//  ForecastHourViewController.swift
//  Test
//
//  Created by Sergey Starchenkov on 25.06.2021.
//

import UIKit
import SnapKit

protocol IForecastHourViewController: AnyObject
{
    func updateUI()
}

final class ForecastHourViewController: UIViewController
{
    let presenter: IForecastHourPresenter
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ForecastHourTableViewCell.self, forCellReuseIdentifier: ForecastHourTableViewCell.identifier)
        return tableView
    }()
    
    init(presenter: IForecastHourPresenter) {
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
        self.configureNavigationBar()
        self.presenter.viewDidLoad(view: self)
    }
}

private extension ForecastHourViewController
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
    
    private func configureNavigationBar() {
            self.navigationController?.navigationBar.backgroundColor = .white
            let leftBarItem = UIBarButtonItem(image: UIImage(systemName: Constants.barItemBackImageName), style: .done, target: self, action: #selector(self.closeTapped))
            self.navigationItem.leftBarButtonItem = leftBarItem
        }
        
        @objc private func closeTapped() {
            self.presenter.didTapClose()
        }
}

extension ForecastHourViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastHourTableViewCell.identifier, for: indexPath) as? ForecastHourTableViewCell else { return UITableViewCell() }
        self.presenter.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension ForecastHourViewController: IForecastHourViewController
{
    func updateUI() {
        self.tableView.reloadData()
    }
}
