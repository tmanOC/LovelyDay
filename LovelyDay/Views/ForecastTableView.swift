//
//  ForecastTableView.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/13.
//

import Foundation
import UIKit

class ForecastTableView: UIView {
    let forecastLabel = UILabel()
    init(width: CGFloat, data: WeatherForecast) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: 400))
        var string = ""
        for item in data.forecast {
            string.append(String(Int(item.temp.rounded())) + "º   " + item.mainWeather + "\n")
        }
        let attributedString = NSAttributedString.attributedStringWithString(string, color: UIColor.white, size: 24)
        forecastLabel.numberOfLines = 0
        forecastLabel.attributedText = attributedString
        forecastLabel.size = attributedString.size()
        self.addSubview(forecastLabel)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
