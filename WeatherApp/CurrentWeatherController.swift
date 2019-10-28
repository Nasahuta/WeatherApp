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
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityTemp: UILabel!
    @IBOutlet weak var cityName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //setCity(cityName: "Tampere")
        let defaultDB = UserDefaults.standard
        if let data = defaultDB.object(forKey: "object") {
            print("alota lataus")
            do {
                let savedCities = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data) as! SavedCities
                if savedCities.selectedCity == "" {
                    apiHandler?.setLocation()
                    print("savedCity: \(savedCities.selectedCity)")
                } else {
                    setCity(cityName: savedCities.selectedCity)
                    apiHandler?.currentLocation = savedCities.selectedCity
                    print("savedCity: \(savedCities.selectedCity)")
                }
                if savedCities.cities.count == 0 {
                    apiHandler?.data.append("Use GPS")
                } else {
                    apiHandler?.data = savedCities.cities
                }
            } catch {
                print("Something went wrong with loading in CurrentWeatherController")
            }
        } else {
            print("Elseen meni")
            apiHandler?.setLocation()
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "Alert", message: "Could not find location", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setCity(cityName: String) {
        self.cityName.text = cityName
        getNewCityInformation()
    }
    
    func setData(temp: String, icon: String) {
        self.cityTemp.text = "\(temp) ºC"
        self.weatherIcon.image = UIImage(named: "\(icon)@2x.png")
    }
    
    func getNewCityInformation() {
        let configuredCityName = cityName.text!.replacingOccurrences(of: " ", with: "+")
        apiHandler?.currentWeather(configuredCityName)
    }
}
