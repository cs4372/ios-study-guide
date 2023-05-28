## Sandboxing

- security feature that restricts an app's access to the system and other apps on an iOS device
- Every app is given a sandbox, a directory it can use to store data in
- Inside the sandbox, an app can only access its own files, resources, and data. It cannot directly access or modify files belonging to other apps or the operating system. This ensures that apps cannot interfere with each other or harm the device

### Where is the Sandbox located?
- In the AppDelegate class, update the application(_:didFinishLaunchingWithOptions:) method as shown below. We ask the operating system for the location of the home directory, the root of the application sandbox.

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    print(NSHomeDirectory())

    return true
}
```

### What does the Sandbox look like?
Add the following to `application(_:didFinishLaunchingWithOptions:)`

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    if let items = try? FileManager.default.contentsOfDirectory(atPath: NSHomeDirectory()) {
        for item in items {
            print(item)
        }
    }

    return true
}
```
Output should look like:
```
.com.apple.mobile_container_manager.metadata.plist
Documents
Library
tmp
```

The first item is a property list used by the operating system. The remaining items are directories that live in every application sandbox on iOS.

### Documents
- ideal for storing data that is directly related to the user
- If your application uses a SQLite database to store the user's data, then the database files could be stored in the Documents directory

### Library
- Caches and Preferences directories. As the name implies, the Caches directory is ideal for storing cached data. This directory can be purged by the operating system when it decides it needs to free up space on the user's device. It goes without saying that this directory is not backed up by iTunes and iCloud.
- Preferences directory contains the property list of the default defaults database. If you store a key-value pair in the default defaults database, that key-value pair is stored in a property list in the Preferences directory.

### tmp
- Temporary data should be stored in the tmp directory
- isn't backed up by iTunes and iCloud

Resources:
- [What is application sandboxing](https://cocoacasts.com/what-is-application-sandboxing/)