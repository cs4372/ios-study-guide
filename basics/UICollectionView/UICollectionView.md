## UICollectionView

- Collection views can display cells in grids, columns, rows, or tables.
- allows you to lay out /customize items however you want
- layouts in grids instead of only rows like a table view
- has a UICollectionViewLayout object, so you can customize the layout of the collection view
- setup is very similar to UITableView
  
Steps:
1. Drag a Collection View to the storyboard and set its constraints to 0 for top, right, bottom and left.
2. Click on the Collection View on storyboard. Right click and drag it to the View Controller. Select Datasource.
3. Move on to ViewController

```
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.systemPurple
        cell.label.text = String(indexPath.item)
        return cell
    }
}
```

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/UICollectionView/UICollectionView.png" height="300"/>

** Use `indexPath.item` in CollectionView and `indexPath.row` in TableView. The values are the same either way.

### Layout using UICollectionViewCompositionalLayout

- Compositional layout lets you construct views by combining different components: sections, groups, and items. 
- A section represents the outer container view that surrounds a group of items.

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/UICollectionView/compositional_layout.png" />

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/UICollectionView/UICollectionViewCompositionalLayout.png" height="300">

1. Create a reference to the Collection View from the View Controller 
2. assign collectionView.collectionViewLayout to a UICollectionViewCompositionalLayout object

Example code:

```
class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.collectionViewLayout = createBasicListLayout()
    }
    
    func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 20
        section.contentInsets.top = 20

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.systemPurple
        cell.label.text = String(indexPath.item)
        return cell
    }
}
```

### Lists in UICollectionView

```
UICollectionLayoutListConfiguration is the only new type required to build a list.
UICollectionLayoutListConfiguration is built on top of NSCollectionLayoutSection as well as UICollectionViewCompositionalLayout.
```

### Build a list
Simple setup

```
let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
let layout = UICollectionViewCompositionalLayout.list(using: configuration)
```

Example Code from [Apple Developer Tutorials](https://developer.apple.com/tutorials/app-dev-training/creating-a-list-view)

```
class ReminderListViewController: UICollectionViewController {
    // Type aliases are helpful for referring to an existing type with a name that’s more expressive.
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>

    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
       
        /*
        Register cells in the collection view, use a content configuration to define the appearance of the cells, and connect the cells to a             data source. You’ll use a diffable data source, which updates and animates the user interface when the data changes.
        */
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item]
            // defaultContentConfiguration() creates a content configuration with the predefined system style.
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
        }
        
        // Configure the data source
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        /*
        Apply a snapshot
        Diffable data sources manage the state of your data with snapshots. A snapshot represents the state of your data at a specific point in         time. To display data using a snapshot, you’ll create the snapshot, populate the snapshot with the state of data that you want to               display, and then apply the snapshot in the user interface.
        */
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map { $0.title })
        dataSource.apply(snapshot)
    }
    // Configure the collection as a list
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
```
[Example of UICollectionView in Storyboard:](https://github.com/cs4372/ios-study-guide/tree/master/basics/UICollectionView/UICollectionView1/UICollectionView1
)

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/UICollectionView/UICollectionView1.png" height="600"/>

Resources:
- https://www.youtube.com/watch?v=cWfG79NaOv4&list=PL0X6fGhFFNTdrYtZQQ5_-5RZ-EhS76-ZK&index=14 
- [WWDC Lists in UICollectionView](https://www.wwdcnotes.com/notes/wwdc20/10026/)
