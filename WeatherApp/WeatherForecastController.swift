//
//  WeatherForecastController.swift
//  WeatherApp
//
//  Created by Joni Alanko on 10/10/2019.
//  Copyright © 2019 Joni Alanko. All rights reserved.
//

import UIKit

class WeatherForecastController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var apiHandler: ApiHandler?
    var forecastTime = [String]()
    var forecastData = [String]()
    var forecastIcon = [String]()
    
    @IBOutlet weak var forecastCityName: UILabel!
    @IBOutlet weak var forecastTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        forecastTable.dataSource = self
        forecastTable.delegate = self
        
        //self.forecastTable.tableFooterView = UIView()
        
        if apiHandler?.currentLocation != nil {
            setCity(cityName: (apiHandler?.currentLocation!)!)
        }
        
        apiHandler!.both = true
        //apiHandler?.setLocation(true)
    }
    
    func setCity(cityName: String) {
        self.forecastCityName.text = cityName
        getNewCityInformation()
    }
    
    func getNewCityInformation() {
        let configuredCityName = forecastCityName.text!.replacingOccurrences(of: " ", with: "+")
        apiHandler?.weatherForecast(configuredCityName)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForecast")! //1.
        
        /*if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellForecast")
        }*/
        
        cell.textLabel?.text = self.forecastData[indexPath.row].capitalized //3.
        cell.detailTextLabel?.text = self.forecastTime[indexPath.row]
        cell.imageView?.image = UIImage(named: self.forecastIcon[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        //print(forecastTime[indexPath.row])
        
        return cell //4.
    }
    
    func setForecastData(_ data: [List]) {
        forecastData = []
        forecastTime = []
        forecastIcon = []
        for point in data {
            forecastData.append(point.weather[0].description + " \(point.main.temp) ºC")
            forecastTime.append(point.dt_txt)
            forecastIcon.append(point.weather[0].icon + "@2x.png")
        }
        
        reloadTable()
    }
    
    func reloadTable() {
        self.forecastTable.reloadData()
    }
}
