## Lifecycle

viewDidLoad()
- Called when content view created in memory / loaded from storyboard
- Gets called `once` in the initial load
- Great for initial setup and one-time-only work
- outlets are guaranteed to have a value

viewWillAppear()
- Called just before content view is added to app's view hierachy, just before it shows up on the screen
- Gets called `every time` when it comes on screen
- e.g. in a navigation controller, everytime you go back to the first screen, viewWillAppear will get called
Usage: set text in text field to empty string

viewDidAppear()
- Called after the content view is added to app's view hierachy
- Usage: start animation 

viewWillDisappear()
- Called before the content view is removed from the app's view hierachy 
- Usage: commiting save changes, say you have a form and before you dismiss it, you want to save everything before the view is gone

viewDidDisappear()
- Called after the content view is removed from the app's hierachy

viewWillLayoutSubviews()
- Called when the content view's bounds change, but BEFORE it lays out its subviews
- Example: when you rotate from portrait to landscape

viewDidLayoutSubviews()
- Called when the content view's bounds change, but AFTER it lays out its subviews
