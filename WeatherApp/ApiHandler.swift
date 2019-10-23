//
//  ApiHandler.swift
//  WeatherApp
//
//  Created by Joni Alanko on 11/10/2019.
//  Copyright © 2019 Joni Alanko. All rights reserved.
//

import Foundation
import CoreLocation

class ApiHandler: NSObject, CLLocationManagerDelegate {
    
    private let operationQueue = OperationQueue()
    
    static let APIKEY: String = "87bcbc00f1636a765c6ad5f9f6795428"
    
    //var locationManager: CLLocationManager!
    
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager()")
        let loc = locations.last
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(loc!, completionHandler: self.done)
        
        self.locationManager.stopUpdatingLocation()
    }*/
    
    func done(placemarks: [CLPlacemark]?, error: Error?) {
        let mark : CLPlacemark! = placemarks?[0]
        print(mark.locality!)
        //weatherForecast(city: mark.locality!)
    }
    
    func weatherForecast(_ city: String) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&APPID=\(ApiHandler.APIKEY)&units=metric"
        fetchUrlForecast(url: url)
    }
    
    func currentWeather(_ city: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(ApiHandler.APIKEY)&units=metric"
        fetchUrlCurrent(url: url)
    }
    
    func fetchUrlCurrent(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetchingCurrent);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func fetchUrlForecast(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetchingForecast);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetchingForecast(data: Data?, response: URLResponse?, error: Error?) {
        //let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        //print(resstr!)
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            do {
                let forecast = try JSONDecoder().decode(ForecastInfoModel.self, from: data!)
                print(forecast.list[0].main.temp)
            } catch {
                print("PARSER ERROR")
            }
        })
    }
    
    func doneFetchingCurrent(data: Data?, response: URLResponse?, error: Error?) {
        //let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        //print(resstr!)
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            do {
                let currentWthr = try JSONDecoder().decode(WeatherObject.self, from: data!)
                print(currentWthr.main.temp)
            } catch {
                print("PARSER ERROR")
            }
        })
    }
    
    convenience init(WhoIsCalling: String, city: String) {
        self.init()
        
        if WhoIsCalling.elementsEqual("CurrentWeatherController") {
            currentWeather(city)
        } else if WhoIsCalling.elementsEqual("WeatherForecastController") {
            weatherForecast(city)
        } else {
            print("Why tho...")
        }

        
        //self.locationManager = CLLocationManager()
        
        /*
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()*/
        
        print("init")
    }
}
