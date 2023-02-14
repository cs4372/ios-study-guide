## UICollectionView

- allows you to lay out /customize items however you want
- layouts in grids instead of rows like a table view
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.systemPurple
        return cell
    }
}

```