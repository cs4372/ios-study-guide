## UITableView

### Steps
1. Open Main.storyboard and drag in a new Table View from the Object Library: 

2. Set top, leading, bottom and trailing contraints to 0

3. Select the Table View, configure Dynamic Prototypes for Content, set Prototype Cells to 1 and select Plain as Style

4. Select the Prototype cell and configure tableCell as Identifier. 

5. Click on Table view and create an IBOutlet called HotelTableView by dragging it to ViewController.swift

6. Done with storyboard. Move on to ViewController.swift. 

Add following code in viewDidLoad:
```
hotelTableView.delegate = self
hotelTableView.dataSource = self
```
We are conforming the protocols (UITableViewDelegate, UITableViewDataSource) in the ViewController. 
- TableViewDatasource protocol => to supply your own data to the tableview
- TableViewDelegate protocol => to notify your ViewController class when user interacts with your tableview.


- The code is setting the data source and delegate of a UITableView object in Swift. 
- The dataSource property is responsible for providing the data to display in the table view, and the delegate property is responsible for handling user interactions with the table view. 


```
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hotelTableView: UITableView!
    
    var hotels = ["Ritz", "Indigo", "Four Seasons", "Hyatt", "Holiday Inn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hotelTableView.delegate = self
        hotelTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    ## what happened when you select cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(hotels[indexPath.row])")
    }
    
    ## return number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    ## return cell content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = hotels[indexPath.row]
        return cell
    }
}
```
