//
//  ForecastHourTableViewCell.swift
//  Test
//
//  Created by Sergey Starchenkov on 25.06.2021.
//

import UIKit
import SVGKit

final class ForecastHourTableViewCell: UITableViewCell
{
    static let identifier = "ForecastHourTableViewCell"
    
    private let imageWeather: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastHourTableViewCell
{
    func set(forecast: ForecastHourEntity) {
        self.hourLabel.text = forecast.hour
        self.tempLabel.text = forecast.temp.description
        
        let nameIcon = forecast.icon
        if let urlSvg = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(nameIcon).svg") {
            if let data = try? Data(contentsOf: urlSvg) {
                let receivedimage: SVGKImage = SVGKImage(data: data)
                self.imageWeather.image = receivedimage.uiImage
            }
        }
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.imageWeather)
        self.contentView.addSubview(self.tempLabel)
        self.contentView.addSubview(self.hourLabel)
    }
    
    private func makeConstraints() {
        self.hourLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
        }
        
        self.imageWeather.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(50)
        }
        
        self.tempLabel.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview().inset(10)
        }
    }
}
