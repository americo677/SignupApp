//
//  ActivityLogDataViewController.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//

import UIKit

class ActivityLogViewController: UIViewController {

    @IBOutlet var activityLogTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTableView(tableView: activityLogTableView, backgroundColor: .clear)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extensión para UITableView

extension ActivityLogViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Inicializador de la tableView de la vista
    func initTableView(tableView: UITableView, backgroundColor color: UIColor) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth]

        tableView.backgroundColor = color

        //let identifier = "cityViewCell"
        //let myBundle = Bundle(for: CityViewController.self)
        //let nib = UINib(nibName: "cityViewCell", bundle: myBundle)

        //tableView.register(nib, forCellReuseIdentifier: identifier)

        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.allowsSelectionDuringEditing = true

        initTableViewRowHeight(tableView: tableView)
    }

    func initTableViewRowHeight(tableView: UITableView) {
        tableView.rowHeight = 41.0
    }

    // MARK: - TableView functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.scSearchController.isActive && self.scSearchController.searchBar.text != "" {
            if self.weatherFiltered.count > 0 {
                return self.weatherFiltered.count
            }
        } else {
            if self.weathers.count > 0 {
                return self.weathers.count
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: WeatherTableViewCell? = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier) as? WeatherTableViewCell

        //var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: WeatherTableViewCell.identifier) as! WeatherTableViewCell
        }

        if self.scSearchController.isActive && self.scSearchController.searchBar.text != "" {
            if self.weatherFiltered.count > 0 {
                self.weather = self.weatherFiltered[indexPath.row]
            }
        } else {
            if self.weathers.count > 0 {
                self.weather = self.weathers[indexPath.row]
            }
        }

        cell?.config(model: self.weather!)
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.scSearchController.isActive && self.scSearchController.searchBar.text != "" {
            if self.weatherFiltered.count > 0 {
                self.weather = self.weatherFiltered[indexPath.row]
            }
        } else {
            if self.weathers.count > 0 {
                self.weather = self.weathers[indexPath.row]
            }
        }
    }

    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
