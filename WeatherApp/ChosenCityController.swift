//
//  ChosenCityController.swift
//  WeatherApp
//
//  Created by Joni Alanko on 10/10/2019.
//  Copyright © 2019 Joni Alanko. All rights reserved.
//

import UIKit

class ChosenCityController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var citiesTable: UITableView!
    @IBOutlet weak var addCityText: UITextField!
    @IBAction func addCityButton(_ sender: Any) {
        if !addCityText.text!.elementsEqual("") {
            data.append(addCityText.text!)
            self.citiesTable.reloadData()
            addCityText.text = nil
        }
    }
    
    
    private var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for i in 0...3 {
            if i == 0 {
                data.append("Use GPS")
            }
            data.append("\(i)")
        }
        
        citiesTable.dataSource = self
        citiesTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == data.count - 1 {
            //data.append("Hello")
            //data.insert("Hello", at: data.count - 1)
            //self.citiesTable.reloadData()
        }
        //print("row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCity")! //1.
        

        let text = data[indexPath.row] //2.

        cell.textLabel?.text = text //3.
        
        return cell //4.
    }
}
