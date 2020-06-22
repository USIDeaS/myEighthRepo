//
//  ViewController.swift
//  RoadRunner
//
//  Created by Anastasia Athans-Stothoff on 6/21/20.
//  Copyright © 2020 Anastasia Athans-Stothoff. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class ViewController: UIViewController {
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    @IBAction func saveRecordButton(_ sender: Any) {
    
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(enterTextField.text!, forKey: "about")
        
        do{
            try self.dataManager.save()
            listArray.append(newEntity)
        }catch{
            print ("Error saving data")
        }
        displayInfoField.text?.removeAll()
        enterTextField.text?.removeAll()
        fetchData()
    
    
    }
    
    @IBAction func deleteRecordButton(_ sender: Any) {
        let deleteItem = enterTextField.text!
        for item in listArray {
            if item.value(forKey: "about") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            }catch {
                print ("Error deleting data")
            }
            displayInfoField.text?.removeAll()
            enterTextField.text?.removeAll()
            fetchData()
            }
       
    }
    
    @IBOutlet var enterTextField: UITextField!
    
    @IBOutlet var displayInfoField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        displayInfoField.text?.removeAll()
        fetchData()
                
        }
    
    func fetchData() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> =
        NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                
            let product = item.value(forKey: "about") as! String
                displayInfoField.text! += product
            }
            
        } catch {
            print ("Error retrieving data")
        }
        
        
    }





}

