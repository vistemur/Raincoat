//
//  CurrentWeatherResponse.swift
//  Raincoat
//
//  Created by Roman Pozdnyakov on 05.06.2023.
//

struct CurrentWeatherResponse: Decodable {
    let weather: [Weather]
    let main: WeatherMain
    let name: String
    
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
