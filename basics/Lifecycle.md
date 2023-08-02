## Lifecycle

`loadView()`
- is called when the view starts loading.
- is a UIViewController method and is responsible for making the `view` property exist in the first place
- When using storyboards, it will load your nib and attach it to the view, but when instantiating view controllers manually, all this method does is create an empty `UIView`
- can override it to change this behaviour and add any kind of view to the view controller's view property

`viewDidLoad()`
- Called when content view created in memory / loaded from storyboard
- Gets called `once` in the initial load
- Great for initial setup and one-time-only work
- outlets are guaranteed to have a value

`viewWillAppear()`
- Called right before your view appears
- Good for hiding/showing fields or any operations that you want to happen `every time` before the view is visible. Because you might be going back and forth between views, this will be called `every time` your view is about to appear on the screen.
- e.g. in a navigation controller, everytime you go back to the first screen, viewWillAppear will get called
- set text in text field to empty string

`viewDidAppear()`
- Called after the content view is added to app's view hierachy
- Usage: start animation 

`viewWillDisappear()`
- Called before the content view is removed from the app's view hierachy 
- Usage: commiting save changes, say you have a form and before you dismiss it, you want to save everything before the view is gone

`viewDidDisappear()`
- Called after the content view is removed from the app's hierachy

`viewWillLayoutSubviews()`
- Called when the content view's bounds change, but BEFORE it lays out its subviews
- Example: when you rotate from portrait to landscape

`viewDidLayoutSubviews()`
- Called when the content view's bounds change, but AFTER it lays out its subviews
