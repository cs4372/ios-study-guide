## Core Data

- Apple’s framework for managing model objects in your application to persist data on all of Apple's platforms

- Operates on in memory.(data needs to be loaded from disk to memory)
- Need to load entire data if we need to drop table or update.
- Fast in terms of record creation.(saving them may be time consuming)

Reasons for using it: Maintaining state between sessions, models the object layer state of app, to preserve data in an app beyond the life of a single app session

`CORE DATA IS NOT A DATABASE`

- Entities are objects representing model data, similar to a simple struct in Swift. E.g. Employee, Order, Person. 
- Core Data represents those as managed objects and saves those in a database, in something called a viewContext. 
- Define an entity like an Employee, and do crud operations like creating ,reading, updating through the viewContext. All that get stored and persisted on disk in a SQLite database. 

#### Setup:

1. Check the CoreData checkbox when you first create a project. It will allow Swift to create the boilerplate Core Data Stack code at the bottom of AppDelegate file. The code sets up the persistentContainer and save the data if there are any changes. 

2. Once project is created, click on the newly created core data file. Add Entity at the bottom, and add attributes associates to the entity. This will translate directly to a swift class. E.g. If we create a Person Entity and add attributes like age and name, then it will be similar to creating a Person class with properties like age and name. This will contain the entity maps/models of what we want to represent our data in the project. 
   
3. We'll be able to create an instance of Person and tell core data to save it so we can retrieve the data later on. By default, core data is going to persist this data into a SQlite database and will translate this into a table in a SQlite database. 

Start with `import CoreData` in ViewController.swift

#### Core Data diagram:

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/CoreData/core-data.png"/>

### Create Records to Core Data
- Refer to persistentContainer from appDelegate
- Create the context from persistentContainer
- Create an instance of Person and pass in viewContext
- Set values for the Person instance
```
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
```

### Retrieve Data
- Prepare the request of type NSFetchRequest for the entity
- if required use predicate for filter data
- Fetch the result from viewContext
- Iterate through an array to get value
```
func retrieveData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let viewContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Person>(entityName: "Person")

    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "username = %@", "Dory")
    fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "age", ascending: false)]

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
``` 

### Update Data
-  Fetch/Retrieve data with predicate as same as above Retrieve data process
-  Retrieve the first object and set new value
```
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
```

### Delete Data
- Fetch/Retrieve data with predicate as same as above Retrieve data process
- Retrieve the first object and remove it
```
func deleteData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let viewContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
    fetchRequest.predicate = NSPredicate(format: "name =%@", "Dory")
    
    do {
        let person = try viewContext.fetch(fetchRequest)
        let result = person[0]
        viewContext.delete(result)
        try viewContext.save()
    } catch let error {
        print("Failed to delete: \(error)")
    }
    
      do {
        try viewContext.save()
            print("saved")
        } catch let error as NSError {
            print("Could not save \(error)")
        }
}
```

### Core Data Codegen 
- Determines how to get access to the two classes Core Data needs to do your processing in Swift and how do we want to generate these files
- It needs a class file where your entity has to extend the NSManagedObject and needs a property file which gives access to all the attribues which you describe in the Data Entity Model. 

#### Class Definition
- Xcode generates both classes for you and XCode manages those files for you 100%
- Run command B and restart the project
- Files don't exist in our project. To find it, go to Navigate, then Show in Finder
- Usecase: if you're fine with no control over the files

#### Manual/None
- Run Shift + Option + Command + K, yhrn run command B to clean and build the project
- Go to the Data Model, click on the Entity, go to Editor and select Create NSManagedObject Subclass. It will generate the files for you and you'll be able to access them in the project
- Pro is that we can add extra functionality here
- Downside is that the files won't be auto-generated if we add an attribute
- Usecase: if you want full control over the files

#### Category/Extension
- You can create the files yourself and add any functions/properties you need
- Files will get updated upon a new build if you add new /rename attributes
- Usecase: if you want some control over the files

Resources:
- https://medium.com/@ankurvekariya/core-data-crud-with-swift-4-2-for-beginners-40efe4e7d1cc
- https://www.youtube.com/watch?v=ZwBIBzs3tuc&t=363s 
- https://github.com/cs4372/ios-projects/blob/master/Core-Data/Core-Data/CoreDataSetup.swift
