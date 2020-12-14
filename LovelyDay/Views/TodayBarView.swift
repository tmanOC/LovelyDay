//
//  TodayBarView.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/13.
//

import Foundation
import UIKit

class TodayBarView: UIView {
    let minLabel = UILabel()
    let maxLabel = UILabel()
    let currentLabel = UILabel()

    init(width: CGFloat, data: DayWeatherInfo) {
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: 60))
        let attributedString = NSAttributedString.attributedStringWithString(String(Int(data.tempMin.rounded())) + "º " + String(Int(data.temp.rounded())) + "º " + String(Int(data.tempMax.rounded())) + "º ", color: UIColor.white, size: 27)
        self.minLabel.attributedText = attributedString
        self.minLabel.size = attributedString.size()
        self.minLabel.x = 10
        self.minLabel.center.y = self.height/2.0
        self.addSubview(self.minLabel)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
