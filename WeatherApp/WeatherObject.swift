//
//  WeatherObject.swift
//  WeatherApp
//
//  Created by Joni Alanko on 22/10/2019.
//  Copyright © 2019 Joni Alanko. All rights reserved.
//

import Foundation

struct WeatherObject : Codable {
    var name : String
    var weather : [Weather]
    var main : Main
}

struct ForecastInfoModel : Codable{
    var list :[List]
}

struct List : Codable {
    var main : Main
    var weather : [Weather]
    var dt_txt : String
}

struct Weather: Codable {
    var description : String
    var icon : String
}

struct Main: Codable {
    var temp : Double
}
