import UIKit
import PlaygroundSupport

class ExampleController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bounds = CGRect(x: 0, y: 0, width: 500, height: 500)
        
        let quote = "Dusty loves food!"

        let firstAttributes: [NSAttributedString.Key: Any] = [.backgroundColor: UIColor.green, NSAttributedString.Key.kern: 10]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
        let firstString = NSMutableAttributedString(string: "Dusty", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "loves ", attributes: secondAttributes)
        let thirdString = NSAttributedString(string: "food!")
        
        firstString.append(secondString)
        firstString.append(thirdString)

        let label = UILabel()
        label.attributedText = firstString
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = CGRect(x: 20, y: 20, width: 275, height: 100)
        
        let attributedString = NSMutableAttributedString(string: "Dusty is the cutest pup in the world. He is a mini goldendoodle and loves to eat!")
        attributedString.addAttribute(.link, value: "https://www.apple.com", range: NSRange(location: 0, length:5))
        let label2 = UILabel()
        label2.attributedText = attributedString
        label2.numberOfLines = 0
        label2.textAlignment = .center
        label2.frame = CGRect(x: 100, y: 100, width: 275, height: 100)
        self.view.addSubview(label)
        self.view.addSubview(label2)
    }
}

let viewController = ExampleController()
PlaygroundPage.current.liveView = viewController
