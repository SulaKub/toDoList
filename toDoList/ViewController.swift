//
//  ViewController.swift
//  toDoList
//
//  Created by Sultan Kubentayev on 18/08/2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        let taskTitle = textFieldTitle.text ?? ""
        let taskDetails = textViewDescription.text ?? ""
        let newTask = TaskItem(name: taskTitle, details: taskDetails, isCompleted: false)
        
//        var newTaskTitle = TaskItem()
//        newTaskTitle.name = taskTitle
        
        do {
            if let data = defaults.data(forKey: "arrayItemTitle"){
                var array = try JSONDecoder().decode([TaskItem].self, from: data)
                array.append(newTask)
                
                let encodedata = try JSONEncoder().encode(array)
                defaults.set(encodedata, forKey: "arrayItemTitle")
            } else {
                let encodedata = try JSONEncoder().encode([newTask])
                defaults.set(encodedata, forKey: "arrayItemTitle")
            }
                
        } catch {
            print("unable to encode \(error)")
        }
        
//        if let arrayTitle = defaults.array(forKey: "arrayTitle"){
//            titleArray = arrayTitle as! [String]
//            titleArray.append(taskTitle)
//        
//            defaults.set(titleArray, forKey: "arrayTitle")
//        } else {
//            let arrayTitle = [taskTitle]
//            defaults.set(arrayTitle, forKey: "arrayTitle")
//        }
//        
//        let arrayTitle = [taskTitle]
        
//        let taskDetails = textViewDescription.text ?? ""
        
//        var newTaskDetails = TaskItem()
//        newTaskDetails.details = taskDetails
        
//        var detailsArray : [String] = []
        
//  
//        do {
//            if let data = defaults.data(forKey: "arrayItemDetails"){
//                var arrayD = try JSONDecoder().decode([TaskItem].self, from: data)
//                arrayD.append(newTaskDetails)
//                
//                let encodedata = try JSONEncoder().encode(arrayD)
//                defaults.set(encodedata, forKey: "arrayItemDetails")
//            } else {
//                let encodedata = try JSONEncoder().encode([newTaskDetails])
//                defaults.set(encodedata, forKey: "arrayItemDetails")
//            }
//                
//        } catch {
//            print("unable to encode \(error)")
//        }
//        
//        if let arrayDetails = defaults.array(forKey: "arrayDetails"){
//            detailsArray = arrayDetails as! [String]
//            detailsArray.append(taskDetails)
//        
//            defaults.set(detailsArray, forKey: "arrayDetails")
//        } else {
//            let arrayDetails = [taskDetails]
//            defaults.set(arrayDetails, forKey: "arrayDetails")
//        }
//        
//        defaults.set(titleArray, forKey: "arrayTitle")
        
//        let detailsArray = [taskDetails]
//        defaults.set(detailsArray, forKey: "arrayDetails")


//        

//        

//        defaults.set(titleArray, forKey: "arrayTitle")
//        defaults.set(detailsArray, forKey: "arrayDetails")
//    
//        
        textFieldTitle.text = ""
        textViewDescription.text = ""
    }
    
}

