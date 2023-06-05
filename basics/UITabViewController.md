## UITabViewController

-  a type of view controller in iOS that manages a tab bar interface
-  provides a tab bar at the bottom of the screen with multiple tabs, each associated with a separate view controller 
-  The tab bar allows users to switch between different sections or modes of an app's user interface

Example: 

```
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let todosVC = TodoListViewController()
        let addTodoVC = AddTodoViewController()

        // Embed the TodosViewController and AddTodoViewController in a UINavigationController
        let todosNavVC = UINavigationController(rootViewController: todosVC)
        let addTodoNavVC = UINavigationController(rootViewController: addTodoVC)

        self.viewControllers = [todosNavVC, addTodoNavVC]
        
        todosNavVC.tabBarItem.title = "Todos"
        addTodoNavVC.tabBarItem.title = "Add Todo"
        
        todosNavVC.tabBarItem.image = UIImage(named: "list.bullet")
        addTodoNavVC.tabBarItem.image = UIImage(named: "plus")
    }
}
```
Inside SceneDelegate

```
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
         let window = UIWindow(windowScene: windowScene)
        window.rootViewController = TabBarController()
         self.window = window
         self.window?.makeKeyAndVisible()
    }
```
