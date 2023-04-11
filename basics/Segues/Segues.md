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

### Unwind Segues 

- Navigate back through pushing push, modal, segues and you. On top of that you can actually unwind through not only one but a series of push/modal/popover segues, e.g. "go back" multiple steps in your navigation hierarchy with a single unwind action.

Scenario:
- Navigation Controllers stack view controllers on top of each other and as you progress, it starts pushing the controllers in a stack and popping off the controllers when you go back. 
- Instead of going back one step at a time, you can go straight from the destination view controller to the root controller using Unwind Segues

E.g. FirstViewController.swift 

```
class ViewController: UIViewController {

    @IBOutlet weak var dataPassedLabel: UILabel!
    
    var dataString = "This is the first controller"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataPassedLabel.text = dataString
    }
    
    // 1. Go to the code for the view controller that you wish to unwind to and add this:
    @IBAction func unwindToFirst(_ sender: UIStoryboardSegue) {}
}
```

....


FourthViewController.swift 

```
class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    /*
     1. In storyboard, go to the view that you want to unwind from and simply drag a segue from your button or whatever up to the little orange "EXIT" icon at the top right of your source view.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        // Pass dataString to FirstViewController
        destinationVC.dataString = "Back from Last Screen"
    }
}
```

Now, the segue will unwind to the FirstViewController when your button is tapped.
