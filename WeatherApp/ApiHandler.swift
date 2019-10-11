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
    
    var locationManager: CLLocationManager!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager()")
        let loc = locations.last
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(loc!, completionHandler: self.done)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func done(placemarks: [CLPlacemark]?, error: Error?) {
        let mark : CLPlacemark! = placemarks?[0]
        print(mark.locality!)
        //weatherForecast(city: mark.locality!)
    }
    
    func weatherForecast(city: String) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&APPID=\(ApiHandler.APIKEY)"
        fetchUrl(url: url)
    }
    
    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        print(resstr!)
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            NSLog(resstr!)
        })
    }
    
    override init() {
        super.init()
        
        weatherForecast(city: "Tampere")

        
        self.locationManager = CLLocationManager()
        
        /*
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()*/
        
        print("init")
    }
}
