//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{

    
    // adding comma "," to adding alt elements, UITextFieldDelegate for example, UItextFieldDelegate use for  editing and validatio
        
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchFieldLabel: UITextField!
    
    var weatherManger = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManger.delegate = self
        searchFieldLabel.delegate = self /// to tell searchFbldLabel to report or read back upper IBoutlet connected, "self" is redefined the whole viewcontroller
    }

    @IBAction func goSearchPressed(_ sender: UIButton) {
        searchFieldLabel.endEditing(true) /// remove keyboard after done editing
        print(searchFieldLabel.text!) // to print text from text
        ///field in after Press search button but not work in go KeyBoard, so  we need to use UI Textfield Delegate  in UIvieController above.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { /// to return value or text after programmed in searchFieldLabel.delegate = self to find what we looking for.
        searchFieldLabel.endEditing(true) /// remove keyboard after done editing
        print(searchFieldLabel.text!)
        return true ///  do not forget to return true or false in Bool
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {/// use textField field because in the it will search the textField func and all input value in funct textField Type
            return true /// if textField having values or text return true
        }else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchFieldLabel.text{
            weatherManger.fetchWeather(cityName: city)
        }
        searchFieldLabel.text = "" /// to tell delete all the texts in search field label bar after pressed search or go, it's related to delegate above. which we already told the whole trigger this function after done editing or putting all texts
    }
    func didUpdateWeather(_ weatherManger: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    func didFailError(error: Error) {
        print(error)
    }
    
}

    
