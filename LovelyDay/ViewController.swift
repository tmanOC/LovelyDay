//
//  ViewController.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/13.
//

import UIKit


class ViewController: UIViewController, MyLocationDelegate {

    var refreshControl: UIRefreshControl?
    var scrollView: UIScrollView?

    static let SUNNY_COLOUR = UIColor.init(red: 0x47, green: 0xAB, blue: 0x2F) //#47AB2F
    static let CLOUDY_COLOUR = UIColor.init(red: 0x54, green: 0x71, blue: 0x7A) //#54717A
    static let RAINY_COLOUR = UIColor.init(red: 0x57, green: 0x57, blue: 0x5D) //57575D

    var todayWeather: DayWeatherInfo?
    var weatherForecast: WeatherForecast?



    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView = UIScrollView(frame: UIScreen.main.bounds)
        self.refreshControl = UIRefreshControl()
        self.scrollView?.refreshControl = self.refreshControl
        self.scrollView?.backgroundColor = ViewController.SUNNY_COLOUR
        self.scrollView.flatMap{ self.view.addSubview($0)}


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Show loader view
        self.view.addLoader()
        MyLocationManager.main.delegate = self
    }

    func mainWeatherUIInfoFrom(weatherString: String) -> (String, UIColor, String) {
        let compareString = weatherString.uppercased()
        if compareString.contains("CLOUD") {
            return ("sea_cloudy", ViewController.CLOUDY_COLOUR, "CLOUDY")
        } else if compareString.contains("RAIN") {
            return ("sea_rainy", ViewController.RAINY_COLOUR, "RAINY")
        } else if compareString.contains("SUN") {
            return ("sea_sunny", ViewController.SUNNY_COLOUR, "SUNNY")
        } else {
            return ("sea_sunny", ViewController.SUNNY_COLOUR, "SUNNY")
        }
    }
    func buildUIWithWeatherData() {
        guard let weather = self.todayWeather else {
            return
        }
        let (mainImageString, mainColour, mainInfoString) = mainWeatherUIInfoFrom(weatherString: weather.mainWeather)

        guard let mainImage = UIImage(named: mainImageString) else {
            return
        }
        let mainImageView = UIImageView(image: mainImage)
        guard let mainScrollView = self.scrollView else {
            return
        }
        mainScrollView.addSubview(mainImageView)
        let aspectRatio = mainImageView.height/mainImageView.width
        mainImageView.width = mainScrollView.width
        mainImageView.height = mainImageView.width * aspectRatio
        mainScrollView.backgroundColor = mainColour

        let mainTempAttributedString = NSAttributedString.attributedStringWithString(String(Int(weather.temp.rounded())) + "º", color: UIColor.white, size: 80)
        let mainTempLabel = UILabel()
        mainTempLabel.attributedText = mainTempAttributedString
        mainTempLabel.size = mainTempAttributedString.size()

        mainTempLabel.center.x = self.view.width/2
        mainTempLabel.center.y = self.view.width/2 - 100.0
        mainScrollView.addSubview(mainTempLabel)

        let mainWeatherAttributedString = NSAttributedString.attributedStringWithString(mainInfoString, color: UIColor.white, size: 40)
        let mainWeatherLabel = UILabel()
        mainWeatherLabel.attributedText = mainWeatherAttributedString
        mainWeatherLabel.size = mainWeatherAttributedString.size()

        mainWeatherLabel.center.x = self.view.width/2
        mainWeatherLabel.y = mainTempLabel.bottom
        mainScrollView.addSubview(mainWeatherLabel)

        let todayBar = TodayBarView(width: self.view.width, data: weather)
        todayBar.y = mainImageView.bottom
        mainScrollView.addSubview(todayBar)

        guard let forecast = self.weatherForecast else {
            return
        }
        let tableView = ForecastTableView(width: self.view.width, data: forecast)
        tableView.y = todayBar.bottom
        mainScrollView.addSubview(tableView)
    }

    func newLocationData(latitude: Double, longitude: Double) {
        //
        var dataFetchCount = 0
        WeatherFetcher.getWeatherInfoForLocation(latitude: latitude, longitude: longitude) { (dayWeatherInfo) in
            print("Got the weather")
            dataFetchCount += 1

            self.todayWeather = dayWeatherInfo
            if dataFetchCount == 2 {
                self.view.removeLoader()
                self.buildUIWithWeatherData()
                // Load UI
            }
        }
        WeatherFetcher.getWeatherForecastForLocation(latitude: latitude, longitude: longitude) {
            (weatherForecast) in
            print("Got the forecast")
            dataFetchCount += 1

            self.weatherForecast = weatherForecast
            if dataFetchCount == 2 {
                self.view.removeLoader()
                self.buildUIWithWeatherData()
                // Load UI
            }
        }
    }
}

