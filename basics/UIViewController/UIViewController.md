## UIViewController

### View Controller
- acts as a bridge between views and your data models. Each view controller is responsible for managing a view hierarchy, updating the content in views, and responding to events in the user interface
- class that controls an instance of UIView, and handles all the logic and code behind it
- the sole owner of its view and any subviews it creates
- manages how we transition from 1 view to another and logic that sets up the user interface

`init?(coder aDecoder: NSCoder)`
- When you use a storyboard or a XIB file to create your view controller, the `init?(coder aDecoder: NSCoder)` initializer will be called automatically.
- The `init?(coder aDecoder: NSCoder)` initializer is required when using programmatic UI.
- The `required init?(coder: NSCoder)` initializer is marked as required because the superclass (UIViewController) implements NSCoding to ensure proper initialization.
- NSCoding is a protocol in the Foundation framework of iOS and macOS that defines a mechanism for encoding (serializing) and decoding (deserializing) objects. In simple terms, it helps us save and load objects easily, so we can store them on a computer, send them over the internet, or use them in different parts of a program.


- UIViewController implements `NSCoding` and it needs to be implemented to ensure propert initialization 

What steps were taken by the application to present the blank view when the app runs?

#### Storyboard version: 
1. System loads the storyboard file which is specified in the project settings
2. Initial view controller defined in the storyboard is instantiated and becomes the app's root view controller
3. The hierarchy of the root view controller (subviews, etc) is loaded from the storyboard
4. The view hierarchy is rendered on the screen and the app's UI becomes visible

#### Programmatic UI:
1. App's entry point is usually defined in AppDelegate's `application(_:didFinishLaunchingWithOptions:)` method
2. In the entry point, a UIWindow is instantiated, which serves as the app's main window
3. Root View Controller is created programmatically and assigned to the window's rootViewController property
4. The hierarchy of the root view controller (subviews, etc) is constructed programmatically
5. Call the window's makeKeyAndVisible() method to make the window and its associated view controller visible on the device's screen
6. The view hierarchy is rendered on the screen and the app's UI becomes visible

## Configure View Controller programmatically 

ViewController.swift
```
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showBlue(_ sender: UIButton) {
        let vc = ColorViewController()
        vc.set(color: UIColor.blue, name: "blue")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)  
    }
}
```

ColorViewController.swift
```
import UIKit

class ColorViewController: UIViewController {
    
    var label: UILabel!
    
    var color: UIColor?
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("inside view did load")
        
        view.backgroundColor = color
        
        label = UILabel()
        label.text = name
        label.textColor = UIColor.white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    @objc func done() {
        dismiss(animated: true, completion: nil)
    }
    
    func set(color: UIColor, name: String) {
        self.color = color
        self.name = name
    }
}
```

## Configure View Controller using Storyboard 

1. Drag a View Controller to Storyboard
2. Create a new file for the View Controller
3. Set Class to the file of the View Controller and StoryboardID to `colorvc`
4. Drag in a label to the middle of screen and a Done button to the top left corner 
5. Connect IBOutlet to the colorLabel by right clicking the label in the ViewController and dragging it to View Controller
6. Connect IBAction to the Back button by right clicking the button in the ViewController and dragging it to View Controller and call dismiss function to dimiss the view controller (transition back to the previous controller)
7. Click on the View Controller in the storyboard and go to the Identity Inspector. 

ViewController

```
@IBAction func showPink(_ sender: UIButton) {
    //using storyboard
    guard let vc = storyboard?.instantiateViewController(identifier: "colorvc") as? ColorView1Controller else {
        return
    }
    vc.set(color: UIColor.systemPink, name: "Pink")
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true, completion: nil)
}
```

ColorView1Controller

```
class ColorView1Controller: UIViewController {
    
    @IBOutlet weak var colorLabel: UILabel!
    
    var color: UIColor?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        colorLabel.text = name

    }
    
    func set(color: UIColor, name: String) {
        self.color = color
        self.name = name
        print("inside set")
    }
    
    @IBAction func clickBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
```

## Configure View Controller using Segue

1. Right on the first view controller in Storyboard and drag it to the new view Controller and click Show under Manual Segue

ViewController

```
@IBSegueAction func showPurple(_ coder: NSCoder) -> ColorView1Controller? {
    //using segue
    guard let vc = ColorView1Controller(coder: coder) else {
        return nil
    }
    vc.set(color: UIColor.purple, name: "purple")
    return vc
    }
```

## Navigation Controller 

- special relationship with the segue so it will be embedded inside of the view controller and push it onto the screen when transition to another view controller, Hence the back button in the another view controller

1. Click on the first View Controller. Click Editor at the top of the file, Embed in and Navigation Controller. It will now be the initial View Controller.

## Tab Controller

1. Click on the Navigation Controller. Click Editor at the top of the file, Embed in and Tab Controller.
2. Create a new controller and right click Tab View Controller and drag it to the new controller. Select view controllers under Relationship segue


see code ^

Resources: 

1. [UIViewControllers in ios and swift](https://www.youtube.com/watch?v=WuSesaZcaMQ)
