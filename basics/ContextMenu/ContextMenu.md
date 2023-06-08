## Context Menu

- presents a menu of actions by performing long-press gesture on the item/view 
- Users can then select an option from the menu to perform the associated action

#### How to create a context menu

- The ViewController class adopts the UIContextMenuInteractionDelegate protocol so that the view controller will handle interactions and configuration related to the context menu
- contextMenuInteraction is implemented as part of the UIContextMenuInteractionDelegate protocol. Called when the context menu is about to be displayed and provides the configuration for the menu

```
class ViewController: UIViewController, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in
                let copy = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { _ in
                    print("Copy was selected")
                }
                let share = UIAction(title: "Share") { _ in
                    print("Share was selected")
                }
                let favorite = UIAction(
                    title: "Favorite",
                    image: UIImage(systemName: "stars"),
                    attributes: .disabled,
                    state: .off) { _ in
                        print("Favorite was selected")
                }
                let remove = UIAction(
                    title: "Remove",
                    image: UIImage(systemName: "trash"),
                    attributes: .destructive,
                    handler: { _ in
                        print("Remove was selected")
                })
                return UIMenu(title: "Hello Menu", children: [copy, share, favorite, remove])
            }
        }
    

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            let square = UIView()
            square.translatesAutoresizingMaskIntoConstraints = false
            square.backgroundColor = .systemBlue
            view.addSubview(square)
            NSLayoutConstraint.activate([
                square.widthAnchor.constraint(equalToConstant: 200),
                square.heightAnchor.constraint(equalToConstant: 200),
                square.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                square.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            
            let menuInteraction = UIContextMenuInteraction(delegate: self)
            square.addInteraction(menuInteraction)
        }
}
```

<img src="https://github.com/cs4372/ios-study-guide/blob/master/basics/ContextMenu/context-menu.png" width="200px">

Resources:

- [Context Menus: iOS](https://www.youtube.com/watch?v=UnA2inRI5g0)
- [Medium article on Context Menus](https://medium.com/ivymobility-developers/context-menus-in-ios-226727a8aa88)
