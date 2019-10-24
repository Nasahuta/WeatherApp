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
    
    @IBOutlet weak var forecastCityName: UILabel!
    @IBOutlet weak var forecastTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        forecastTable.dataSource = self
        forecastTable.delegate = self
        
        self.forecastTable.tableFooterView = UIView()
        
        apiHandler?.weatherForecast("Tampere")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForecast")! //1.
        
        
        cell.textLabel?.text = self.forecastData[indexPath.row] //3.
        cell.detailTextLabel?.text = self.forecastTime[indexPath.row]
        print(forecastTime[indexPath.row])
        return cell //4.
    }
    
    func setForecastData(_ data: [List]) {
        forecastData = []
        for point in data {
            forecastData.append(point.weather[0].description + " \(point.main.temp) C")
            forecastTime.append(point.dt_txt)
        }
        
        reloadTable()
    }
    
    func reloadTable() {
        self.forecastTable.reloadData()
    }
}
