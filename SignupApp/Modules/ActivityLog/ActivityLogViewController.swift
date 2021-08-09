//
//  ActivityLogDataViewController.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//

import UIKit

protocol ActivityLogManagerViewProtocol: class {
    var presenter: ActivityLogPresenterProtocol? { get set }
}


class ActivityLogViewController: UIViewController, ActivityLogManagerViewProtocol {

    @IBOutlet var activityLogTableView: UITableView!

    var presenter: ActivityLogPresenterProtocol?
    var userData: UserData?
    
    var activityLogs = [ActivityLogData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter = ActivityLogPresenter()
        self.presenter?.view = self
        
        // carga de actividad
        activityLogs = (self.presenter?.getLog(userData: userData!))!
        
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

        let identifier = "logCell"
        let myBundle = Bundle(for: ActivityLogViewController.self)
        let nib = UINib(nibName: "logCell", bundle: myBundle)

        tableView.register(nib, forCellReuseIdentifier: identifier)

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
        return (self.activityLogs.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell") as! ActivityLogTableViewCell
            
        let activityLog: ActivityLogData = (activityLogs[indexPath.row])
        
        cell.activityResultLabel.text = activityLog.result
        cell.activityDateLabel.text = activityLog.date
        
        return cell
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
