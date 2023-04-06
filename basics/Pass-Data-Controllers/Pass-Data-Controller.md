## Pass Data between Controllers

1. Using Segues
- built-in mechanism in iOS for transitioning between screens in an app. 
- You can use them to pass data from one controller to another by setting a property of the destination controller before the segue is performed.

FirstViewController.swift

```
class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        let name = textField.text ?? ""
            
        // store the instance of the SecondViewController
        let destinationVC = segue.destination as! SecondViewController
        // set the variable from the SecondViewController that will receive the data
        destinationVC.labelText = name
    }
}
```

SecondViewController.swift

```
class SecondViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    //store the data from the first ViewController
    var labelText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "Hello, " + labelText
    }
}
```

2. Using Delegates

- Delegates are a design pattern that allows one object to communicate with another. 
- It allows an object to communicate back with its owner.

Steps:
- Define a protocol that the destination controller (in the case, ViewController) conforms to 
- Set the source controller as its delegate in the ViewController This way, the source controller (SecondViewController) can send data to the destination controller by calling methods on its delegate.

ViewController

```
class ViewController: UIViewController, passDataDelegate {

    @IBOutlet weak var labelText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func sendData(data: String) {
        labelText.text = data
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "MySegueIdentifier" {
             if let destinationVC = segue.destination as? SecondViewController {
                2. Set delegate of the secondViewController to ViewController
                 destinationVC.delegate = self
             }
         }
     }
}
```

SecondViewController
```
1. A delegate protocol to define the requirements to pass data
protocol passDataDelegate {
    func sendData(data: String)
}

class SecondViewController: UIViewController {
    
    var delegate: passDataDelegate?

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func clickBtn(_ sender: UIButton) {
        if let text = textField.text {
            3. Call methods on its delegate
            delegate?.sendData(data: text)
            dismiss(animated: true, completion: nil)
        }
    }
}
```