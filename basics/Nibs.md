## Nibs (Next Interface Builder)

- visual representation of the design and layout views in Xcode
- break it down into smaller components unlike storyboards
- represented in XCode today as .xib 

How to load a nib into a View Controller?

1. ### Simplest way is to create the nib (same name as view controller)
- Set it's File's Owner to the ViewController
- Point the File's Owner `view` to the nib view


2. ### Load up the nib from the bundle when the view controller's view loads

- grab its first view (Nibs can have multiple views in them)
- add it as a subview to the view controller's view

```
class ViewController: UIViewController {
  override function viewDidLoad() {
    super.viewDidLoad()
    if let nib = Bundle.main.loadNibNamed("View", owner: self),
       let nibView = nib.first as? UIView {
         nibView.frame = view.bounds
         nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         view.addSubview(nibView)
    }
  }
}
```

3. ### Load up the nib inside LoadView()
- UIViewController has a function called loadView(). We can override this function and set the view property to whatever we choose

```
class ViewController: UIViewController {
  
  override func loadView() {
    super.loadView()
    if let nib = Bundle.main.loadNibNamed("View", owner: self),
       let nibView = nib.first as? UIView {
         view = nibView
    }
  }
}
```

** If you want to setup some IBOutlets on the view controller for this view you’d set the ‘file owner’ in the Nib to be ‘ViewController’. **

Resources:
- [Loading Nibs in iOS](https://chris-mash.medium.com/loading-nibs-in-ios-9a9c4b05985f)
- [What are Nibs? (Swift/iOS)](https://www.youtube.com/watch?v=XPA7WsMsKoU)