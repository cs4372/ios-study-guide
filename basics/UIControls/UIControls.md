## UIControls

UIControl is a subclass of UIView that detects user interactions and notify our code if something happens. A button is still a UIView, but also a UIControl. Any UI views that handle user inputs like buttons, sliders, switches are UIControls. If any of the events get trigged like sliding a switch, clicking a button, then we can respond to it using Swift.

```
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let button = UIButton(type: .system)
        button.setTitle("Click", for: .normal)
        // button.setTitle("Highlighted", for: .highlighted)
        button.frame = CGRect(x: 20, y: 20, width: 200, height: 100)
        button.addTarget(self, action: #selector(doSomething), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func doSomething(_ button: UIButton) {
        print("hiii")
    }

    @IBAction func clickButton(_ sender: UIButton) {
        print("click button")
    }
    
    @IBAction func toggleSwitch(_ toggleSwitch: UISwitch) {
        print(toggleSwitch.isOn)
    }
    
    @IBAction func moveSlider(_ slider: UISlider) {
        print("slider.val", slider.value)
    }
}
```