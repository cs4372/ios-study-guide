## Auto Layout

- Remember to set `translatesAutoresizingMaskIntoConstraints = false` so we can have control over the view's constraints and how it responds to changes in the layout.
#### Activiate a batch of constraints at once
```
NSLayoutConstraint.activate([
        
])
```

### Centered Horizontally 

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/AutoLayout/autolayout-horizontal.png"/>

```
centeredView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
```

### Centered Vertically 

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/AutoLayout/autolayout-vertical.png"/>

```
centeredView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
```

### Middle of screen

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/AutoLayout/autolayout-middle.png"/>

```
centeredView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
centeredView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
```

### Alignments

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/AutoLayout/autolayout-labels.png"/>

Right click the label under the top label and select Vertical Spacing to align vertically to the top label



Example:
```
import UIKit

class LoginView: UIView {
    
    let stackView = UIStackView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        backgroundColor = .secondarySystemFill
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        // Round a corner
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    func layout() {
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
```

### Round a corner 
```
layer.cornerRadius = 5
clipsToBounds = true
```
The clipsToBounds property is a property of UIView that determines whether subviews that extend beyond the bounds of the view should be clipped or not.

### Instrinsic content size
- Labels have _instrinsic content size_, meaning we don’t need to explicitly set their size unless we want their size to be different than what they already are. They can size themselves. 
- We can override them if we want to make the labels wider.
- Image views have an intrinsic content size when they have an image in them, but they don’t when they are empty.

### Aspect ratios
- are the ratio between the width and the height of an image.
- If an image has the same height and width (which we do in this case) the aspect ration will be 1:1. But other times the aspect ration may be something different - like 4:3.
  
 ```
logo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
```

Make the width of the logo view three-quarters (0.75) of its height. This constraint ensures that the logo view maintains a specific aspect ratio between its width and height.

Resources:
- [Using aspect ratios with auto layout](https://holyswift.app/using-aspect-ratio-with-auto-layout-in-ios/)
