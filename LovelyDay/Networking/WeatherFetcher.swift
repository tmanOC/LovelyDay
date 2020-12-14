//
//  WeatherFetcher.swift
//  LovelyDay
//
//  Created by Tielman Janse van Vuuren on 2020/12/13.
//

import Foundation
import Alamofire

struct DayWeatherInfo {
    var temp: Float
    var tempMax: Float
    var tempMin: Float
    var mainWeather: String
    var date: Date?

    static let weatherDateFormatter = dateTimeFormatter()

    static func dateTimeFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }

    static func dateFromWeatherData(data: [String: Any]) -> Date? {
        guard let dateTimeString = data["dt_txt"] as? String else {
            return nil
        }
        return DayWeatherInfo.weatherDateFormatter.date(from: dateTimeString)
    }

    static func getFloatFromAny(value: Any?) -> Float? {
        if let string = value as? String, let floatValue = Float(string) {
            return floatValue
        } else if let newValue = value as? Float {
            return newValue
        } else if let doubleValue = value as? Double {
            return Float(doubleValue)
        }
        return nil
    }

    static func dayWeatherInfoFrom(data: Any?) -> DayWeatherInfo? {

        guard let weatherInfo = data as? [String: Any] else {
            return nil
        }
        guard let mainInfo = weatherInfo["main"] as? [String: Any] else {
            return nil
        }
        guard let rainData = weatherInfo["weather"] as? [[String: Any]] else {
            return nil
        }
        guard rainData.count > 0 else {
            return nil
        }
        guard let mainWeather = rainData[0]["main"] as? String else {
            return nil
        }
        guard let temp = getFloatFromAny(value: mainInfo["temp"]) else {
            return nil
        }
        guard let tempMax = getFloatFromAny(value: mainInfo["temp_max"]) else {
            return nil
        }
        guard let tempMin = getFloatFromAny(value: mainInfo["temp_min"]) else {
            return nil
        }

        return DayWeatherInfo(temp: temp - 273.15, tempMax: tempMax - 273.15, tempMin: tempMin - 273.15, mainWeather: mainWeather, date: dateFromWeatherData(data: weatherInfo))
    }
}

struct WeatherForecast {


    var forecast: [DayWeatherInfo]

    static func isTime12PM(time: String) -> Bool {
        let dateTimeStrings = time.split(separator: " ")
        guard dateTimeStrings.count == 2 else {
            return false
        }
        let timeStrings = dateTimeStrings[1].split(separator: ":")
        guard timeStrings.count > 0 else {
            return false
        }
        return timeStrings[0] == "12"
    }

    static func weatherForecastFrom(data: Any?) -> WeatherForecast? {
        guard let allData = data as? [String: Any] else {
            return nil
        }
        guard let forecastData = allData["list"] as? [[String: Any]] else {
            return nil
        }
        //To keep it simple go with weather at 1200 for the forecast.
        let keptData = forecastData.filter {
            guard let timeString = $0["dt_txt"] as? String else {
                return false
            }
            return isTime12PM(time: timeString)
        }
        let forecast:[DayWeatherInfo] = keptData.compactMap {
            DayWeatherInfo.dayWeatherInfoFrom(data: $0)
        }
        return WeatherForecast(forecast: forecast)
    }
}


class WeatherFetcher {
    static let apiKey = "a1f2c9c9bd87c8223a2c031bf4aab7ac"
    class func getWeatherInfoForLocation(latitude: Double, longitude: Double, completion: @escaping (DayWeatherInfo?) -> ()) {
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=" + String(latitude) + "&lon=" + String(longitude) + "&appid=" + apiKey).responseJSON { (response) in
            completion(DayWeatherInfo.dayWeatherInfoFrom(data: response.value))
            print(response)
        }
    }

    class func getWeatherForecastForLocation(latitude: Double, longitude: Double, completion: @escaping (WeatherForecast?) -> ()) {
        AF.request("https://api.openweathermap.org/data/2.5/forecast?lat=" + String(latitude) + "&lon=" + String(longitude) + "&appid=" + apiKey).responseJSON { (response) in

            completion(WeatherForecast.weatherForecastFrom(data: response.value))
            print(response)
        }
    }
}
