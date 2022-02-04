//
//  WeatherController.swift
//  Clima
//
//  Created by Nhok Phal on 8/1/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManger: WeatherManager, weather: WeatherModel)
    func didFailError(error: Error)
}

struct WeatherManager {
    let weatherURl =
    "https://api.openweathermap.org/data/2.5/weather?&appid=dd40a4f7f8f569b9d073d9e155e56f80&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String) {
        let urlstring = "\(weatherURl)&q=\(cityName)"
        return performRequest(with: urlstring)
        /// simply connect the 2 fuction tgt
    }
    func performRequest(with urlstring: String){ // land here as the input function
        
        // 1. create a URL
        if let url = URL(string: urlstring) {
            /// 2. create a URL season
            let session = URLSession(configuration: .default) // set config to default
            // 3.give the session a task
            //            let task = session.dataTask(with: url, completionHandler: handle(data:urlresponce:error:)) convert to handler
            let task = session.dataTask(with: url) { (data, responce, error) in
                if error != nil {
                    self.delegate?.didFailError(error: error!)
                    return // do nothing
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                      self.delegate?.didUpdateWeather(self, weather: weather) /// use delegate method
//                        weatherVC.didUpdateWeather(weather: weather)
//
                    }
                }
            }
            // basically input data from handle functin, if it passed it will check value in data,urlresponce and error
            
            task.resume()
            /// we use resume coz task can be supspended
            
        } // we use optional and if let in case it failed or typo error
        
    }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id /// will print data from weather data struct main then temp
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            return weather
        }catch {
            delegate?.didFailError(error: error)
            return nil
}

}

}
