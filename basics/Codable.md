## Codable 

- protocol in Swift to convert JSON data into Swift structs 
- a union of two protocols: Encodable and Decodable. When you only want to convert JSON data into a struct, you can conform your object to `Decodable`. If you only want to transform instances of your struct into Data, you can conform your object to `Encodable`, and if you want to do both you can conform to `Codable`.
- A lot of Swift's built-in types already conform to Codable by default. For example, Int, String, and Bool are Codable out of the box.

### Customizing how Codable objects map to JSON data

Example of server response:

```
{
    "id": 10,
    "full_name": "Donny Wals",
    "is_registered": false,
    "email_address": "address@domain.tld"
}
```

If you were to define this model as a Swift struct, it'd look like this:

```
struct User: Codable {
  let id: Int
  let full_name: String
  let is_registered: Bool
  let email_address: String
}
```

This struct is valid Swift, but it doesn't follow Swift conventions and best practices.

```
struct User: Codable {
  let id: Int
  let fullName: String
  let isRegistered: Bool
  let emailAddress: String
}
```

Now, this looks better but we can't use this struct to decode the JSON from earlier because it will return an error ton state that the JSONDecoder could not find a corresponding key in the JSON data for the fullName.

To make our decoding work, the simplest way to achieve this is to configure the JSONDecoder's keyDecodingStrategy to be .convertFromSnakeCase. This will automatically make the JSONDecoder map full_name from the JSON data to fullName in struct by converting from snake case to camel case.

```
do {
  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  let user = try decoder.decode(User.self, from: jsonData)
  print(user)
} catch {
  print(error)
}
```

### Defining a Codable struct

Example of a JSON:

```
{
    "hello": "world",
    "someInt": 10,
    "someBool": true
}
```

Model this data using Swift struct:

```
struct ExampleStruct: Decodable {
    let hello: String
    let someInt: Int
    let someBool: Bool
}
```

A more complex example of a JSON structure: 

```
{
  "status": "active",
  "objects": [
    {
      "id": 1,
      "name": "Object one",
      "available": true
    },
    {
      "id": 2,
      "name": "Object two",
      "available": false
    },
  ]
}
```

Model this data:

```
struct Response: Decodable {
  let status: ResponseStatus
  let objects: [Product]
}

struct Product: Decodable {
  let id: Int
  let name: String
  let available: Bool
}

enum ResponseStatus: String, Decodable {
  case active = "active"
  case inactive = "inactive"
}
```

To convert your Data to an instance of your struct, you need a JSONDecoder instance. You can create one as follows:

```
let decoder = JSONDecoder()
```

Full code: 

```
URLSession.shared.dataTask(with: URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(query)")!, completionHandler: { data, response, error in
    guard let data = data, error == nil else {
        return
    }

    // Convert
    var result: Recipes?
    do {
        result = try JSONDecoder().decode(Recipes.self, from: data)
        self.resultsNotFound = false
        print("result", result)
    }
    catch {
        print("inside catch")
        self.resultsNotFound = true
        DispatchQueue.main.async {
            self.emptyResults()
        }

        print("Failed to decode data")
    }
```

Recipes.swift 

```
struct Recipes: Codable {
    var meals: [Recipe]
}
```

Recipes.swift 
```
struct Recipe: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strSource: String
    let strMealThumb: String
}

```

Assuming json looks like the following 
```
{"meals":[{"idMeal":"52955","strMeal":"Egg Drop Soup","strCategory":"Vegetarian","strMealThumb":"https:\/\/www.themealdb.com\/images\/media\/meals\/1529446137.jpg","strSource":"https:\/\/sueandgambo.com\/pages\/egg-drop-soup", .... }]}
```

Resources:
- https://www.donnywals.com/an-introduction-to-working-with-codable-in-swift/