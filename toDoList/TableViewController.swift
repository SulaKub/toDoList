//
//  TableViewController.swift
//  toDoList
//
//  Created by Sultan Kubentayev on 18/08/2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    var titlearray : [TaskItem] = []
    var detailsarray : [TaskItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        do {
            if let data = defaults.data(forKey: "arrayItemTitle"){
                let array = try JSONDecoder().decode([TaskItem].self, from: data)
                titlearray = array
            }
        
        } catch {
            print("unable to encode \(error)")
        }
        
//        if let arrayTitle = defaults.array(forKey: "arrayTitle"){
//            titlearray = arrayTitle as! [String]
//        }
        do {
            if let data = defaults.data(forKey: "arrayItemDetails"){
                let arrayD = try JSONDecoder().decode([TaskItem].self, from: data)
                detailsarray = arrayD
            }
        
        } catch {
            print("unable to encode \(error)")
        }
        
//        if let arrayDetails = defaults.array(forKey: "arrayDetails"){
//            detailsarray = arrayDetails as! [String]
//        }
        
        tableView.reloadData()
    }
    
    func saveTask(){
        let defaults = UserDefaults.standard
        
        do {
            let encodedata = try JSONEncoder().encode(titlearray)
            defaults.set(encodedata, forKey: "arrayItemTitle")
                
        } catch {
            print("unable to encode \(error)")
        }
        
//        defaults.set(titlearray, forKey: "arrayTitle")
//        defaults.set(detailsarray, forKey: "arrayDetails")

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titlearray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        let task = titlearray[indexPath.row]
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = task.details

        //MARK: - Trenar code
        cell.accessoryType = task.isCompleted ? .checkmark : .none
//        if titlearray[indexPath.row].isCompleted {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        titlearray[indexPath.row].isCompleted.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
//        tableView.reloadData()
        saveTask()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            titlearray.remove(at: indexPath.row)
//            detailsarray.remove(at: indexPath.row)
        
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveTask()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}
