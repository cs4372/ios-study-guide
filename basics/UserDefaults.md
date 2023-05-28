## User Defaults

- useful for storing `small` pieces of data in your app
- common to save your app's settings/set some flags or simply use as a tiny data store
- The user defaults is a .plist file in your app’s package
- structure is very similar to that of a dictionary

```
// Access Shared Defaults Object
let userDefaults = UserDefaults.standard
```

### Writing or Setting Values To User Defaults
```
// Access Shared Defaults Object
let userDefaults = UserDefaults.standard

let dictionaryKey = "myDict"

// Write/Set Value
userDefaults.set(true, forKey: "myKey")
userDefaults.set(5.25, forKey: "Price")
userDefaults.set(Date(), forKey: "lastEditedPostTime")
userDefaults.set("Dusty Buns", forKey: "Name")
let array = [3,4,5]
userDefaults.set(array, forKey: "Array")
let dictionary = ["name": "Dusty"]
userDefaults.set(dictionary, forKey: dictionaryKey)
```

### Reading or Getting Values From User Defaults
```
let userDefaults = UserDefaults.standard

// Read/Get Value
let lastEditedTime = userDefaults.object(forKey: "lastEditedPostTime")
let myArray = userDefaults.array(forKey: "Array") as! [Int]
let myDictionary = userDefaults.dictionary(forKey: dictionaryKey)
let value = userDefaults.bool(forKey: "myKey")

// Check if val is a Boolean
let value = userDefaults.object(forKey: "myKey") as? Bool ?? false
```

When to use User Defaults?
- if you need to store small amounts of data that don't need to be secured
-  do not store sensitive information such as username / user token

References:
- https://github.com/cs4372/ios-projects/tree/master/Todo-List/Todo-List

Resources:
- https://cocoacasts.com/ud-1-how-to-use-user-defaults-in-swift
