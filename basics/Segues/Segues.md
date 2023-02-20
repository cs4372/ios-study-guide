## Segues

### Pass data through segue

#### In The First ViewController (Send The Value)

```
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSecondViewController" {
        let secondViewController = segue.destination as! SecondViewController
        secondViewController.name = "Cat"
    }
}
```

#### In the second viewController (Catch The Value)
```
@IBOutlet weak var nameLabel: UILabel!
var name = ""
override func viewDidLoad() {
    super.viewDidLoad()
    nameLabel.text = name
}
```

### Segue in a TableView

#### In The First ViewController (Send The Value)

```
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var clickedRow = 0
    
    @IBOutlet weak var tableView: UITableView!
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        clickedRow = indexPath.row
        performSegue(withIdentifier: "toSecondViewController", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondViewController" {
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.name = "Cat"
            secondViewController.clickedRow = clickedRow
        }
    }
}
```

#### In the second viewController (Catch The Value)
```
class SecondViewController: UIViewController {
    
    var clickedRow = 0
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = String(clickedRow)
        
    }
}
```

