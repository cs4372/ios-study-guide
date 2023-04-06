## Firebase

- a mobile and web application development platform that provides a variety of tools and services for building modern, cloud-based applications
- offers a wide range of services including authentication, real-time database, cloud storage, cloud messaging, hosting, machine learning, etc
- known for its real-time data synchronization capabilities, which enable developers to build applications that automatically update in real-time as data changes, without the need for manual refreshes


[Firebase Setup](https://firebase.google.com/docs/ios/setup)

All Firebase Realtime Database data is stored as JSON objects. You can provide your own keys, such as user IDs or semantic names, or they can be provided for you using `childByAutoId`.

```
import Firebase
```

In AppDelegate, we need to add the following inside `didFinishLaunchingWithOptions`:

```
FirebaseApp.configure()
```

### Realtime Database: 

## Create Data 

To read or write data from the database, you need an instance of DatabaseReference:

```
var ref: DatabaseReference!

ref = Database.database().reference()
```

Save data to a specified reference:
- Use `setValue` to save data to a specified reference, replacing any existing data at that path. 

```
ref.childByAutoId().setValue(["name": "Dusty", "age": 5, "job": "student"])
```

- user
   - age
   - name
   - role

```
ref.child("user/name").setValue("Dusty")
```

## Read Data 

```
ref.child("user.name").observeSingleEvent(of: .value) { (snapshot) in
    let userData = snapshot.value as? [String: Any]
}
```

## Update Data 

```
let updates = ["user/name": "Teddy", "user1/name": "Floofy"]
ref.updateChildValues(updates)
```

## Remove Data

```
ref.child("user").removeValue() // going to delete the key as well
```

## observeSingleEvent vs observe

observeSingleEvent - retrieves the data once and then stops listening for changes

observe - continuously listens for changes and updates the data locally whenever there is a change in the database

## Best practices for data structure

- Avoid nesting
- Flatten data structures