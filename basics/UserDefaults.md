## User Defaults

- useful for storing small pieces of data in your app
- common to save your app's settings/set some flags or simply use as a tiny data store
- The user defaults is a .plist file in your app’s package
- structure is very similar to that of a dictionary

```
// Access Shared Defaults Object
let userDefaults = UserDefaults.standard
```

### Reading or Getting Values From User Defaults
```
let userDefaults = UserDefaults.standard

// Read/Get Value
userDefaults.object(forKey: "myKey")

// Read Boolean
let value = userDefaults.bool(forKey: "myKey")

// Read Boolean
let value = userDefaults.object(forKey: "myKey") as? Bool ?? false
```

### Writing or Setting Values To User Defaults
```
// Access Shared Defaults Object
let userDefaults = UserDefaults.standard

// Write/Set Value
userDefaults.set(true, forKey: "myKey")
userDefaults.set("Dusty Buns", forKey: "Name")
```

When to use User Defaults?
- if you need to store small amounts of data that don't need to be secured
-  do not store sensitive information such as username / user token

Resources:
- https://cocoacasts.com/ud-1-how-to-use-user-defaults-in-swift