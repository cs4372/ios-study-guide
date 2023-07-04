## Playground

To display a live view in the playground, create a new playground and add the following at the top of the file:

```
import UIKit
import PlaygroundSupport
```

Make sure that Live View is selected from the pop-up menu.

Make sure to add the following code to create an instance  of the controller class and display its view in the playground's live view.

```
PlaygroundPage.current.liveView = {controllerClass}()
```

### Boilerplate:

```
import UIKit
import PlaygroundSupport

class ExampleController: UIViewController {
     override func viewDidLoad() {
          super.viewDidLoad()

          self.view.bounds = CGRect(x: 0, y: 0, width: 375, height: 667)
     }
}

PlaygroundPage.current.liveView = ExampleController()
```

E.g.

```
import UIKit
import PlaygroundSupport

class TableViewExampleController: UIViewController, UITableViewDataSource {

     var tableView:UITableView?

     var names:[String] = [ "Dusty","Teddy","Pepe"]

     override func viewDidLoad() {
          super.viewDidLoad()

          self.view.bounds = CGRect(x: 0, y: 0,           width: 375, height: 667)

          createTableView()
     }

     func createTableView() {
          self.tableView = UITableView(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))

          self.tableView?.dataSource = self
          self.tableView?.backgroundColor = .white

          self.tableView?.register(UITableViewCell.self,  forCellReuseIdentifier: "Cell")

          self.view.addSubview(self.tableView!)
     }

     func tableView(_ tableView: UITableView,     numberOfRowsInSection section: Int) -> Int {
          names.count

     }

     func tableView(_ tableView: UITableView,     cellForRowAt indexPath: IndexPath) ->     UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)

          let name = names[indexPath.row]
          cell.textLabel?.text = name
          return cell
     }
}

PlaygroundPage.current.liveView = TableViewExampleController()
```


