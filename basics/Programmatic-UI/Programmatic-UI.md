## Auto Layout

Auto Layout constraints allow us to create views that dynamically adjust to different size classes and positions. 

#### Steps to remove storyboard in project: 
1. Remove Storyboard 
2. Click on the Project, in this case, AutoLayout. Go to info, under Custom iOS Target Properties, remove `Main storyboard file base name` and `Storyboard name` under Scene Configuration

#### Lay out a user interface

1. Frame (Less preferred)

```
let button = UIButton()
self.view.addSubview(button)
button.frame = CGRect(x: 100, y: 100, width: 120, height: 44)
````

1. Programmatic Auto Layout


#### Writing constraints by using Layout Anchors

- set the `translatesAutoresizingMaskIntoConstraints` to false. This is to prevent the view’s auto-resizing mask to be translated into Auto Layout constraints and affecting your constraints.

```
button.translatesAutoresizingMaskIntoConstraints = false
```


#### Create  an array of constraints
```
NSLayoutConstraint([
    view.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
    view.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
    view.widthAnchor.constraint(equalToConstant: 100),
    view.heightAnchor.constraint(equalTo: view.widthAnchor)
])
```

This creates a square and centers it in its superview. The last line is needed to actually activate the constraints so they make your layout appear as expected.

#### Use of Navigation Controller 

ViewController
```
override func viewDidLoad() {
    super.viewDidLoad()
    
   .....
    
    button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
}

@objc func clickButton() {
    let vc = SecondViewController()
    self.navigationController?.pushViewController(vc, animated: true)
}
```

Scene Delegate
Inside scene, 
```
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = UINavigationController(rootViewController: ViewController())
    self.window = window
    self.window?.makeKeyAndVisible()
}
```

#### Presents a view controller modally
Similar to above, but update in ViewController
```
@objc func clickButton() {
    let vc = SecondViewController()
    self.present(vc, animated: true, completion: nil)
}
```

and Scene Delegate
```
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
     window.rootViewController = ViewController()
    self.window = window
    self.window?.makeKeyAndVisible()
}
```
