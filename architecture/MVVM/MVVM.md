## MVVM 

<img src="https://github.com/cs4372/ios-study-guide/blob/master/architecture/MVVM/MVVM.png" height="200"/>

View Model
- receives info from View Controller, `handles this information and transforms it into values that can be displayed in a view`, and sends it back to VC

Model
- Same model as in MVC
- simply holds the data and has nothing to do with business logic
- used by `View Model and updates whenever VM sends new updates`


MVVMModel

```
struct MVVMModel { 
    let firstName: String
    let lastName: String
    let score: Int
}
```

```
struct MVVMViewModel { 
    let name: String
    let level: String

    init(_ mvvmModel: MVVMModel) { 
        name = "\(mvvmModel.firstName) \(mvvmModel.lastname)"
        if mvvmModel.score <= 40 { 
            level = "Beginner"
        } else if mvvmModel.score <= 70 { 
            level = "Intermediate"
        } else { 
            level = "Expert"
        }
    }
}
```

View Controller 

```
class MVVMTableViewController: UITableViewController { 
    var data: [MVVMModel] = []

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
        cell.mvvmViewModel = MVVMViewModel(data[indexPath.row])
        return cell
    }
}
```

TableViewCell 

```
class MVVMTableViewCell: UITableViewCell { 
    static let identifier = "MVVMTableViewCell"

    var mvvmViewModel: MVVMViewModel! { 
        didSet { 
            textLabel?.text = mvvmViewModel.name
            detailTextLabel?.text = mvvmViewModel.level
        }
    }

    ....
}
```
