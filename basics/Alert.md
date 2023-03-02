## Alerts

### Create Alert

```
var dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
// Create OK button with action handler
let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
    print("Ok button tapped")
})
// Create Cancel button with action handlder
let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
    print("Cancel button tapped")
}
//Add OK and Cancel button to an Alert object
dialogMessage.addAction(ok)
dialogMessage.addAction(cancel)
// Present alert message to user
self.present(dialogMessage, animated: true, completion: nil)
```

### Pause app to stop all interactions
```
let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
activityIndicator.center = self.view.center
activityIndicator.hidesWhenStopped = true
activityIndicator.activityIndicatorStyle = activityIndicator.gray
view.addSubview(activityIndicator)
activityIndicator.startAnimating()
UIApplication.shared.beginIgnoringInteractionEvents()
UIApplication.shared.endIgnoringInteractionEvents()

Resources:
- https://www.appsdeveloperblog.com/how-to-show-an-alert-in-swift/