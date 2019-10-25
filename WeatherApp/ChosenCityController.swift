//
//  ChosenCityController.swift
//  WeatherApp
//
//  Created by Joni Alanko on 10/10/2019.
//  Copyright © 2019 Joni Alanko. All rights reserved.
//

import UIKit

class ChosenCityController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var apiHandler: ApiHandler?
    var currentWeather: CurrentWeatherController?
    var forecast: WeatherForecastController?
    
    private var data: [String] = []
    
    @IBOutlet weak var citiesTable: UITableView!
    @IBOutlet weak var addCityText: UITextField!
    @IBAction func addCityButton(_ sender: Any) {
        if !addCityText.text!.elementsEqual("") && !hasSpecialCharacters(addCityText.text!) {
            data.append(addCityText.text!.capitalized.trimmingCharacters(in: .whitespaces))
            self.citiesTable.reloadData()
            addCityText.text = nil
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "Alert", message: "Could not find location", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hasSpecialCharacters(_ searchTerm: String) -> Bool {
        let charset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if (searchTerm.rangeOfCharacter(from: charset.inverted) != nil) {
            return true
        }
        
        return false
    }
    
    func giveClasses(currentWeather: CurrentWeatherController, forecast: WeatherForecastController, apiHandler: ApiHandler) {
        self.currentWeather = currentWeather
        self.forecast = forecast
        self.apiHandler = apiHandler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        data.append("Use GPS")
        data.append("Tampere")
        data.append("Helsinki")
        
        citiesTable.dataSource = self
        citiesTable.delegate = self
        
        self.citiesTable.tableFooterView = UIView()
        //alert()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("row: \(indexPath.row)")
        print("row: \(data[indexPath.row])")
        if indexPath.row == 0 {
            apiHandler?.setLocation()
        } else {
            apiHandler?.currentLocation = data[indexPath.row]
            currentWeather?.setCity(cityName: data[indexPath.row])
            if apiHandler!.both {
                forecast?.setCity(cityName: data[indexPath.row])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCity")! //1.
        

        let text = data[indexPath.row] //2.

        cell.textLabel?.text = text //3.
        
        return cell //4.
    }
}
