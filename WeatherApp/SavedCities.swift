//
//  SavedCities.swift
//  WeatherApp
//
//  Created by Joni Alanko on 28/10/2019.
//  Copyright © 2019 Joni Alanko. All rights reserved.
//

import Foundation

class SavedCities: NSObject, NSCoding {
    var selectedCity: String = ""
    var cities: [String] = []
    
    init(selectedCity: String, cities: [String]) {
        self.selectedCity = selectedCity
        self.cities = cities
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(selectedCity, forKey: "selectedCity")
        aCoder.encode(cities, forKey: "cities")
    }
    
    required init?(coder aDecoder: NSCoder) {
        selectedCity = aDecoder.decodeObject(forKey: "selectedCity") as! String
        cities = aDecoder.decodeObject(forKey: "cities") as! [String]
    }
}
