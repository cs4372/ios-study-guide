## How to access Camera Roll 

Add a new row in Info.plist and add key "Privacy - Photo library Usage Description" and value.

```
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        } else {
            print("Error getting image")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
```

Add UIImagePickerControllerDelegate protocol to notify your delegate when the user either picks an image or movie, or cancels the picker operation. The delegate methods are responsible for dismissing the picker when the operation completes. (https://developer.apple.com/documentation/uikit/uiimagepickercontrollerdelegate)

Why do we use UINavigationControllerDelegate? (https://stackoverflow.com/questions/54988309/uiimagepickercontroller-and-uinavigationcontrollerdelegate-implementation)
- UIImagePickerController inherits from UINavigationController
- Some of the UIImagePickerControllerDelegate methods like imagePickerControllerDidCancel(_:) requires to communicate with UINavigationController in order to receive events
