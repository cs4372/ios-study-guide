## Parse

- service that allows app developers to effortlessly add a backend to their apps without worrying about server setup and maintenance. With some basic setup, one is able to get a database and RESTful API up and running. Additionally, it is easy to further add push notification and social integration capabilities in your app.

### Parse Setup

1. Install Cocoapods (library dependencies). Here is a [guide](https://guides.cocoapods.org/using/getting-started.html) on how to get started. Run `sudo gem install cocoapods`
2. Navigate to the project and run `pod init` to initialize a new pod file. Then, run `open -a Xcode Podfile` to create the Podfile. 

`Note: Sometimes, running the command doesn't work, so manually open the podfile instead.`

4. Add following line `pod 'Parse'`

Podfile should look like this:
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ios-project' do
  # Comment the next line if you don't want to use dynamic frameworks
   use_frameworks!

  # Pods for ios-project

  pod 'Parse'

end

```
4. Run `pod install` to fetch the latest file from cocoapods and install it to the project. You should now have the latest parse release.

Note: If you have to delete the podfile and restart the procee again: Run `pod deintegrate` and `rm podfile.loc`

5. After installation, multiple files will be created in the project. Close the project and and click on the one that ends with `.xcworkspace`. Open this file and you should be able to see the pods and all the project files.

## Parse Server setup 

1. Go to https://www.back4app.com/ and create an account 
2. Get the application Id and client key from App Settings -> Security & Keys.

```
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = {appId}
            $0.clientKey = {clientKey}
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        return true
    }
```
3. Setup instructions: https://www.back4app.com/docs/get-started/parse-sdk 

### Save Objects
https://docs.parseplatform.org/ios/guide/#saving-objects
```
let tweet = PFObject(className:"Twitter")
tweet["id"] = 1
tweet["content"] = "This is a tweet"
tweet["displayLocation"] = true
tweet.saveInBackground { (succeeded, error)  in
    if (succeeded) {
        // The object has been saved.
    } else {
        // There was a problem, check error.description
    }
}
```

### Retrieving Objects (get id from Parse dashboard)
https://docs.parseplatform.org/ios/guide/#retrieving-objects
```
let query = PFQuery(className:"Twitter")
query.getObjectInBackground(withId: {id}) { (tweet, error) in
    if error == nil {
        // Success!
        if let tweet = tweet { 
            print(tweetObj)
        }
    } else {
        // Fail!
    }
}
```

### Updating Objects
https://docs.parseplatform.org/ios/guide/#updating-objects
```
let tweet = PFQuery(className:"Twitter")
query.getObjectInBackground(withId: {id}) { (tweet: PFObject?, error: Error?) in
    if let error = error {
        print(error.localizedDescription)
    } else if let tweet = tweet {
        tweet["content"] = "Updated Content"
        tweet["displayLocation"] = false
        tweet.saveInBackground()
    }
}
```
