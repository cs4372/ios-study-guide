## UITableView

### Steps
1. Open Main.storyboard and drag in a new Table View from the Object Library: 
<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view1.png" height="300"/>

2. Set top, leading, bottom and trailing contraints to 0
<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view2.png" height="300"/>
<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view5.png" height="300"/>

3. Select the Table View, configure Dynamic Prototypes for Content, set Prototype Cells to 1 and select Plain as Style.
<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view3.png" height="100"/>

4. Select the Prototype cell and configure tableCell as Identifier. Set Row height to ~120. 
<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view4.png" height="100"/>

5. Create a class called TableViewCell and add the following code to the file:

```
class TableViewCell: UITableViewCell {
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelLocation: UILabel!
    @IBOutlet weak var imageName: UIImageView!
}
```
6. Go back to ViewController and click on tableCell in the file structure section. Go to Custom Class and set Class to TableViewCell.

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view6.png" />

7. Click on Table view and create an IBOutlet called HotelTableView by dragging it to ViewController.swift

8. Done with storyboard. Move on to ViewController.swift. 

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

9. Drag a new View Controller to the storyboard so that we can view the detail of the selected hotel when we click on the cell. Add all the labels and image views to the storyboard. Set up constraints. Then, add a segue by holding Control and right click View Controller (first orange icon in image below), then drag it to the newly created Detail View Controller. Click on the arrow that is pointing to the new controller and go to the attributes inspector, then set Identitfier to detailSegue.

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view7.png" />

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view8.png" />

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view9.png" />

### Table View in View Controller 

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view10.png" />

### Detail Controller

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/TableView/Images/table-view11.png" />

** A segue defines a transition between two view controllers in your app’s storyboard file.

### How to swipe to delete UITableViewCells

```
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    } ...
}
```
## Code:

## View Controller

```
class ViewController: UIViewController {

    @IBOutlet weak var hotelTableView: UITableView!
    
    var hotels = [Hotel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hotelTableView.delegate = self
        hotelTableView.dataSource = self
        renderHotelData()
    }
    
    func renderHotelData() {
        let hotel1 = Hotel(id: "1", name: "Ritz", imageName: "andaz", location: "Germany")
        hotels.append(hotel1)

        let hotel2 = Hotel(id: "2", name: "Four Seasons", imageName: "fourseasons_budapest", location: "Budapest")
        hotels.append(hotel2)

        let hotel3 = Hotel(id: "3", name: "Royal Mansour", imageName: "royal_mansour", location: "Morocco")
        hotels.append(hotel3)

        let hotel4 = Hotel(id: "4", name: "The Silo", imageName: "the_silo", location: "South Africa")
        hotels.append(hotel4)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        let hotel = hotels[indexPath.row]
        cell.hotelName?.text = hotel.id + ". " + hotel.name
        cell.hotelLocation?.text = hotel.location
        cell.imageName?.image = UIImage(named: hotel.imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            let indexPath = self.hotelTableView.indexPathForSelectedRow!
            let tableViewDetail = segue.destination as? TableViewDetail
            let selectedHotel = hotels[indexPath.row]
            tableViewDetail!.selectedHotel = selectedHotel
            self.hotelTableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
```

## Table View Detail
```
import UIKit

class TableViewDetail: UIViewController {
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelLocation: UILabel!
    @IBOutlet weak var imageName: UIImageView!
    
    var selectedHotel: Hotel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hotelName.text = selectedHotel.id + ". " + selectedHotel.name
        hotelLocation.text = selectedHotel.location
        imageName.image = UIImage(named: selectedHotel.imageName)
    }
}
```
