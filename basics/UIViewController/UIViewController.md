## UIViewController

### View Controller
- class that controls an instance of UIView, and handles all the logic and code behind it
- the sole owner of its view and any subviews it creates
- manages how we transition from 1 view to another and logic that sets up the user interface

What steps were taken by the application to present the blank view when the app runs?

1. When the app runs, a new window is created
2. Application goes to the storyboard to get the initial view controller is
3. Creates an new instance of this view controller
4. Takes that view controller's view and puts it in the main window 

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
2. 



