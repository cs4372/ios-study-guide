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

3. Using Singletons

- provides a global point of access to a single instance of a class, making it easy to share data or functionality across different parts of your code
- by ensuring that only one instance of a class exists, you can avoid inconsistencies and ensure that all parts of your app are using the same data or functionality

Disadavantages:
- difficult to test because they introduce global state into your code, which can make it hard to isolate and test individual components
- can introduce tight coupling between different parts of your code, making it difficult to change or replace them later on

DataManager.swift 
```
class DataManager {
    //  creates a singleton instance of the DataManager class, which can be 
    // accessed from anywhere in your app
    static let shared = DataManager() // 
    var textToDisplay: String?
}
```

FirstViewController.swift 

```
import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    @IBAction func buttonTapped(_ sender: UIButton) {
        if let text = textField.text {
            DataManager.shared.textToDisplay = text
        }
    }
    
    // ...
}
```

SecondViewController.swift 
```
import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let text = DataManager.shared.textToDisplay {
            label.text = text
        }
    }
    
    // ...
}
```

4. Using Closures

Example 1:

```
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setText(_ text: String) {
         //override the label with the parameter received in this method
        textLabel.text = text
       }
}
```

```
class SecondViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    func getText() -> String {
        //returns the pet that is selected, as a String
        if let text = textField.text {
            return text
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func textClick(_ sender: UIButton) {
        if let vc = presentingViewController as? ViewController {
               //before dismissing the Form ViewController, pass the data inside the closure
                 dismiss(animated: true, completion: {
                     vc.setText(self.getText())
             })
         }
     }
}
```

Example 2 (MVVM):

```
class WeatherViewController {
    var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        self.viewModel.didUpdateWeatherData = { [weak self] in
            self?.updateUI()
        }
    }
    
    func updateUI() {
        // Update the user interface with the latest weather data from the ViewModel
        let temperature = viewModel.temperature
        let weatherDescription = viewModel.weatherDescription
        // Update labels, icons, etc.
    }
    
    func fetchWeatherButtonTapped() {
        viewModel.fetchWeatherData()
    }
}

// ViewModel
class WeatherViewModel {
    var didUpdateWeatherData: (() -> Void)?
    
    func fetchWeatherData() {
        // Fetch weather data from a service or API
        // Once the data is fetched, update the properties and invoke the callback closure
        let temperature = 25.0
        let weatherDescription = "Sunny"
        
        // Update ViewModel properties
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        
        // Notify the View about the updated weather data
        didUpdateWeatherData?()
    }
}

let weatherViewModel = WeatherViewModel()
let weatherView = WeatherViewController(viewModel: weatherViewModel)

weatherView.fetchWeatherButtonTapped()
````
- WeatherViewController observes changes in the WeatherViewModel through the `didUpdateWeatherData` callback closure.
- When the fetchWeatherData() method is called in the ViewModel, it updates its properties and invokes the callback closure to notify the View. The View then updates its user interface based on the new weather data.


5. Notification Center:

 When the user taps the button in the first view controller, a notification is sent with the text data, and the second view controller receives the notification and uses the text data as needed.

FirstViewController.swift
```
@IBAction func buttonTapped(_ sender: UIButton) {
    let textToPass = textField.text ?? ""
    let data = ["text": textToPass]
    // Sends a notification with the data to be passed
    NotificationCenter.default.post(name: Notification.Name("TextNotification"), object: nil, userInfo: data)
}
```

SecondViewController.swift
```
override func viewDidLoad() {
    super.viewDidLoad()
    // add an observer for the notification with the same name
    // handleNotification function is called when the notification is received
    NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name("TextNotification"), object: nil)
}

@objc func handleNotification(_ notification: Notification) {
    if let data = notification.userInfo as? [String: String], let text = data["text"] {
        // Use the text here
    }
}
```
