//
//  CurrentWeatherController.swift
//  WeatherApp
//
//  Created by Joni Alanko on 10/10/2019.
//  Copyright © 2019 Joni Alanko. All rights reserved.
//

import UIKit

class CurrentWeatherController: UIViewController {
    
    var apiHandler: ApiHandler?
    
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setCity(cityName: "Tampere")
    }
    
    func setCity(cityName: String) {
        self.cityName.text = cityName
        getNewCityInformation()
    }
    
    func setTemp(temp: String) {
        self.cityTemp.text = "\(temp) C"
    }
    
    func getNewCityInformation() {
        let configuredCityName = cityName.text!.replacingOccurrences(of: " ", with: "+")
        apiHandler?.currentWeather(configuredCityName)
    }
}
