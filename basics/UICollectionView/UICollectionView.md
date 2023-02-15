## UICollectionView

- allows you to lay out /customize items however you want
- layouts in grids instead of rows like a table view
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

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/UICollectionView/UICollectionViewCompositionalLayout.png" height="300">

1. Create a reference to the Collection View from the View Controller 
2. assign collectionView.collectionViewLayout to a UICollectionViewCompositionalLayout object


Resources:
- https://www.youtube.com/watch?v=cWfG79NaOv4&list=PL0X6fGhFFNTdrYtZQQ5_-5RZ-EhS76-ZK&index=14 