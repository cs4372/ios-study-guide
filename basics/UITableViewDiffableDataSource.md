## UITableViewDiffableDataSource
- class was first introduced in iOS 13, which is a modern way to supply a table view with the data to display
- The common way would be to use `UITableView` to create the table view in which we have to explicitly adopt both `UITableViewDataSource` and `UITableViewDelegate` protocols
- As more devices are adopting iOS 13 (or up), the UITableViewDiffableDataSource approach will become the standard implementation of UITableView

#### Step 1:  Create an enum which indicates the table sections

UITableView supports multiple sections, thus the UITableViewDiffableDataSource object also requires us to specify the number of sections and the cell configuration of each section. For a simple app, we can have one section. Declare an enum in the controller like this:

```
enum Section {
    case all
}
```

- We use enum to define a new Section type. In the enumeration, it only has one case because the table has a single section. I name the case all , which means all records.

#### Step 2: Create a UITableViewDiffableDataSource object to connect with your table and provide the configuration of the table view cells. 

provide the configuration of the table view cells.
- Create an instance of UITableViewDiffableDataSource . We will write a new function called configureDataSource() for this purpose. Insert the following code in the view controller.

```
func configureDataSource() -> UITableViewDiffableDataSource<Section, String >{
    let cellIdentifier = "datacell"
    let dataSource = UITableViewDiffableDataSource<Section, String>(
        tableView: tableView,
        cellProvider: {  tableView, indexPath, restaurantName in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellI
dentifier, for: indexPath)
            cell.textLabel?.text = restaurantName
            cell.imageView?.image = UIImage(named: "restaurant")
return cell }
)
    return dataSource
}
```

The type Section and String inside the angle bracket indicated that we use the Section type for the table section and the String type for the table cell data. The reason why String type is used is that the restaurant name is of the type String.

Add the following code to view controller 
```
lazy var dataSource = configureDataSource()
```

Step 3: Assign the diffable data source to your table view. 
Generate the current state of the table data by creating a snapshot. Call the apply() function of the data source to populate the data
```
override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = dataSource
    var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
    snapshot.appendSections([.all])
    snapshot.appendItems(restaurantNames, toSection: .all)
    dataSource.apply(snapshot, animatingDifferences: false)
}
```

Resources:
Chapter 9 in Beginning iOS Programming with Swift and UIKit (iOS 15)


