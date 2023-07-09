## MVVM 

<img src="https://github.com/cs4372/ios-study-guide/blob/master/architecture/MVVM/MVVM_diagram.png" height="300"/>

### Model
- Data model / entity that your app has
- Simply structs/classes with associated properties
- Holds the data that has been mapped from raw data structure derived from APIs / databases 
- Used by `View Model and updates whenever VM sends new updates`

### View / View Controller
- Visual element that gets displayed on the UI
- All the UI components on an app screen are views
- Contains only the UI logic, such as data rendering, navigation

### View Model
- Receives UI events and perform business logic, transforming it into values that can be displayed on the UI
- Does not modify the UI or has any reference to the view

### Example 
#### Model

```
struct Model { 
    let firstName: String
    let lastName: String
    let score: Int
}
```

```
struct ViewModel { 
    let name: String
    let level: String

    init(_ model: Model) { 
        name = "\(model.firstName) \(model.lastname)"
        if model.score <= 40 { 
            level = "Beginner"
        } else if model.score <= 70 { 
            level = "Intermediate"
        } else { 
            level = "Expert"
        }
    }
}
```

#### View Controller 

```
class MVVMTableViewController: UITableViewController { 
    var data: [ViewModel] = []

    override func viewDidLoad() { 
        super.viewDidLoad() { 
            title = "MVVM"
            tableView.register(MVVMTableViewCell.self, forCellReuseIdentifier: MVVMTableViewCell.Identifier)
            fetchData()
        }
    
    fileprivate func fetchData() { 
        Service.fetchMVVMData { (result) in 
            switch result { 
                case .success(let data): 
                    self.data = data
                    self.tableView.reloadData()
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }

    // Table view data source 

    override func numberOfSections(in tableView: UITableView) -> Int { 
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
        let cell = tableView.dequeueReusableCell(withIdentifier: MVVMTableViewCell.identifier, for: indexPath) as! MVVMTableViewCell
        cell.viewModel = viewModel(data[indexPath.row])
        return cell
    }
}
```

#### TableViewCell 

```
class MVVMTableViewCell: UITableViewCell { 
    static let identifier = "MVVMTableViewCell"

    var viewModel: ViewModel! { 
        didSet { 
            textLabel?.text = viewModel.name
            detailTextLabel?.text = viewModel.level
        }
    }

    ....
}
```

### Why MVVM?

1. Clear separation of concerns
   - between View, ViewModel and Model, providing us with a more modularized code structure
2. Avoid Bulky Controllers
   - In MVC, as our app grows, controllers can become bloated and difficult to maintain. With MVVM, we move the business logic to ViewModel to help us organize and seperate code effectively
3. Testability
   - ViewModel contains the business logic, which can be easily unit tested without dependencies

Resources:
- [MVVM-1: A General Discussion](https://medium.com/swift-india/mvvm-1-a-general-discussion-764581a2d5d9)
- [How to implement MVVM pattern with Swift in iOS](https://johncodeos.com/how-to-implement-mvvm-pattern-with-swift-in-ios/)
- [Fetching & Displaying API Data (MVVM, UIKit)](https://www.youtube.com/playlist?list=PLWOgAHhZbsIEh3dgGno4CPPsVcb4QUFy7)
- [How not to get desperate with MVVM implementation] (https://medium.com/@koromikoneo/how-to-use-a-model-view-viewmodel-architecture-for-ios-46963c67be1b)
