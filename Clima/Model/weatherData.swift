//
//  weatherData.swift
//  Clima
//
//  Created by Nhok Phal on 8/1/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData: Codable { // typealias Codable = Decodable & Encodable
    let name: String
    let main: Main
    let weather: [Weather]  // use bracket becoz we use wit array
        
}
    /// this struct is import and analysis from json data which contain header of each object so we create another struct to import its object
struct Main: Codable {
    let temp: Double
/// property shoud match with json data
}


struct Weather: Codable {
    let description: String
    let id: Int // scrape data from json 
}
