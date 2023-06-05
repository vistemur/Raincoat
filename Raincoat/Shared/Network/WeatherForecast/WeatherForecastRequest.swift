//
//  WeatherForecastRequest.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 05.06.2023.
//

import Foundation

class WeatherForecastRequest: RCRequest {
    typealias Model = WeatherForecastResponse
    
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double,
         longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    var httpMethod: HttpMethod = .GET
    var query: String = "https://api.openweathermap.org/data/2.5/forecast"
    
    var urlParameters: [String : String] {
        [
            "lat": "\(latitude)",
            "lon": "\(longitude)",
            "lang": "ru",
            "units": "metric",
            "exclude": "minutely,alerts,current",
            "appid": Bundle.main.object(forInfoDictionaryKey: "weatherApiKey") as? String ?? "",
        ]
    }
}
