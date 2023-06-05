//
//  WeatherForecastResponse.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 05.06.2023.
//

import Foundation

struct WeatherForecastResponse: Decodable {
    let list: [ListElement]
    
    struct ListElement: Decodable {
        let dt: String
        let weather: [Weather]
        let main: WeatherMain
        
        var date: Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.date(from: dt)
        }
        
        enum CodingKeys: String, CodingKey {
            case dt = "dt_txt"
            case weather
            case main
        }
        
        struct Weather: Decodable {
            let description: String
            let icon: String
        }
        
        struct WeatherMain: Decodable {
            let temperature: Double
            let temperatureMin: Double
            let temperatureMax: Double
            
            enum CodingKeys: String, CodingKey {
                case temperature = "temp"
                case temperatureMin = "temp_min"
                case temperatureMax = "temp_max"
            }
        }
    }
}
