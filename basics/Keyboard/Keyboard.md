## Keyboard

```
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
        so View Controller has the power that it needs over the text 
        field to resign the first responder and shuts down keyboard
        */
        textField.delegate = self
    }
    
    // shut down the keyboard if user taps anywhere outside of text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // shut down the keyboard if user taps Return on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
```