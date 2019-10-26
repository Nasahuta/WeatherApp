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
    
    var currentWeather: CurrentWeatherController?
    var forecast: WeatherForecastController?
    
    private let operationQueue = OperationQueue()
    
    static let APIKEY: String = "87bcbc00f1636a765c6ad5f9f6795428"
    
    var currentLocation: String?
    var both: Bool = false
    
    var locationManager: CLLocationManager?
    var locations : CLLocationCoordinate2D?
    
    var geoCoder = CLGeocoder()
    var location : CLLocation?
    
    var placemark: CLPlacemark?
    
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager()")
        let loc = locations.last
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(loc!, completionHandler: self.done)
        
        self.locationManager.stopUpdatingLocation()
    }*/
    
    func setLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
            
            self.locations = self.locationManager?.location?.coordinate
            self.location = CLLocation(latitude: (self.locations?.latitude)!, longitude: (self.locations?.longitude)!)
            geoCoder.reverseGeocodeLocation(location!, completionHandler: {(placemarks, error) -> Void in
                var place: CLPlacemark!
                place = placemarks?[0]
                self.placemark = placemarks?[0]
                if place.locality != nil {
                    self.currentLocation = place.locality!
                    self.currentWeather?.setCity(cityName: place.locality!)
                    if self.both {
                        self.forecast?.setCity(cityName: place.locality!)
                    }
                    print(place.locality!)
                } else {
                    
                }
            })
        } else {
            currentLocation = "Tampere"
            self.currentWeather?.setCity(cityName: currentLocation!)
            if self.both {
                self.forecast?.setCity(cityName: currentLocation!)
            }
        }
    }
    
    func giveClasses(currentWeather: CurrentWeatherController, forecast: WeatherForecastController) {
        self.currentWeather = currentWeather
        self.forecast = forecast
    }
    
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
                self.forecast?.setForecastData(forecast.list)
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
                self.currentWeather?.setData(temp: String(currentWthr.main.temp), icon: String(currentWthr.weather[0].icon))
                print(currentWthr.weather[0].icon)
                
            } catch {
                print("PARSER ERROR")
            }
        })
        
    }
    
    convenience init(currentWeather: CurrentWeatherController, forecast: WeatherForecastController, locationManager: CLLocationManager) {
        self.init()
        
        self.currentWeather = currentWeather
        self.forecast = forecast
        self.locationManager = locationManager
        
        //setLocation()
        /*
        if WhoIsCalling === CurrentWeatherController {
            currentWeather(city)
        } else if WhoIsCalling.elementsEqual("WeatherForecastController") {
            weatherForecast(city)
        } else {
            print("Why tho...")
        }*/

        
        //self.locationManager = CLLocationManager()
        
        /*
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()*/
        
        print("init")
    }
}
