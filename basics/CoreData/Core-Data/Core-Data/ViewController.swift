//
//  ViewController.swift
//  Core-Data
//
//  Created by Catherine Shing on 2/23/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deleteData()
        retrieveData()
    }
    
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let cat = Person(context: viewContext)
        cat.name = "Dory"
        cat.age = 10
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        var people: [Person] = []
        
        do {
            people = try viewContext.fetch(fetchRequest)
        } catch {
            print("Fail to retrieve data")
        }
        people.forEach { person in
            print("\(person.name) \(person.age)")
        }
    }
    
    func updateData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "name =%@", "Dory")
        
        do {
            let person = try viewContext.fetch(fetchRequest)
            let result = person[0]
            result.age = 50
        } catch let error {
            print("Failed to update: \(error)")
        }
    }
    
    func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "name =%@", "Dory")
        
        do {
            let person = try viewContext.fetch(fetchRequest)
            let result = person[0]
            viewContext.delete(result)
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }
}

