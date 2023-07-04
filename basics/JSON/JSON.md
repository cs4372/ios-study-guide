## JSON

- text-based, lightweight, and easy way for storing and exchanging data
- used for representing structural data and data exhange in client-server applications
- Since the release of iOS 5 (2011), Apple introduced `NSJSONSerialization` to automatically convert JSON formatted data to objects (OLD)
- Since the release of Swift 4 (2019), Apple introduced the `Codable` protocol together with the new `JSONDecoder` to simplify the whole JSON serialization process (NEW)

### Quick example to convert a JSON object to a struct  if you don't have time to read the notes below:
```
let person = """
{
    "name": "Dusty",
    "age": 5,
    "full_name": "Dusty Teddy"
}
"""

//1 - Create a model
struct Person: Codable {
    var name: String
    var age: Int
    var fullName: String
}

//2 - Convert the string to data
let personData = Data(person.utf8)

//3 - Create a JSONDecoder instance
let jsonDecoder = JSONDecoder()

//4 - set the keyDecodingStrategy to convertFromSnakeCase on the jsonDecoder instance
jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

//5 - Use the jsonDecoder instance to decode the json into a Person object
do {
    let decodedPerson = try jsonDecoder.decode(Person.self, from: personData)
    print("Person -- \(decodedPerson.name) was decode and their age is: \(decodedPerson.age)")
} catch {
    print("Error: \(error.localizedDescription)")
}
```


Example of API in JSON format:

```
loans: [{
  "id": 2526524,
  "name": "Janet",
  "funded_amount": 0,
  "image": {
    "id": 5088139,
    "template_id": 1
  },
  "sector": "Food",
  "use": "to purchase a bag of flour, a bag of potatoes, cooking oil, fish and cooking ingredients.",
  "location": {
    "country_code": "SB",
    "country": "Solomon Islands",
    "town": "Honiara",
    "geo": {
      "level": "town",
      "pairs": "-9.445638 159.9729",
      "type": "point"
    }
  },
  "posted_date": "2023-02-24T21:20:26Z",
  "loan_amount": 725,
}.....
```

### NSJSONSerialization (Old WAY)
- automatically convert JSON formatted data to objects
- Cons => we had to manually parse the JSON data, convert it into dictionaries and create the Loan objects.

```
func getLatestLoans() {
    guard let loanUrl = URL(string: loanURL) else {
        return
    }
    
    let request = URLRequest(url: loanUrl)
    
    //  data task to retrieve contents from API
    //  Once the request completes, it returns the data (as well as errors) by calling the completion handler.
    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
        
        if let error = error {
            print(error)
            return
        }
        
        // Parse JSON data
        if let data = data {
            self.loans = self.parseJsonData(data: data)
            
            /* Update table view's data
            The block of code in the completion handler of the data task is executed in a background thread. If you call the reloadData method in the background thread, the data reload will not happen immediately. To ensure a responsive GUI update, this operation should be performed in the main thread
            */
            OperationQueue.main.addOperation({
                self.updateSnapshot()
            })
        }
    })
    
    task.resume()
}

func parseJsonData(data: Data) -> [Loan] {
    
    var loans = [Loan]()
    
    do {
        // capable of converting JSON to Foundation objects and converting Foundation objects to JSON
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
        
        /*
         Parse JSON data
         Each of the array items (i.e. jsonLoan) is converted into a dictionary. In the loop, we extract the loan data from each of the dictionaries and save them in a Loan object.
        */
        let jsonLoans = jsonResult?["loans"] as! [AnyObject]
        for jsonLoan in jsonLoans {
            var loan = Loan()
            loan.name = jsonLoan["name"] as! String
            loan.amount = jsonLoan["loan_amount"] as! Int
            loan.use = jsonLoan["use"] as! String
            let location = jsonLoan["location"] as! [String:AnyObject]
            loan.country = location["country"] as! String
            loans.append(loan)
        }
        
    } catch {
        print(error)
    }
    
    return loans
}
 ```

 ## Decodable and Encodable Protocols)

 Swift has three protocols that makes working with JSON simple and straightforward — Decodable, Encodable, and Codable.

 ### Encodable
- Convert instances of a struct to a JSON object. Most commonly this is used to __send data to the server__.

 ### Decodable
 - Convert JSON data into a struct Most commonly this is used when __receiving data from the server__.

 ### Codable
- A type alias for both Encodable and Decodable which allows your type to be used to encode and decode JSON.
- Some may prefer to be explicit with their naming and stick with the Encodable and Decodable, but just mark as Codable unless told otherwise.
- A lot of Swift's built-in types already conform to Codable by default. For example, Int, String, and Bool are Codable out of the box.

### Coding Keys
- The property naming convention in Swift is camelCase.
- Some APIs will have keys formatted other than camelCase. To keep your code clean and follow the Swift convention, Swift offers a CodingKey protocol. This protocol will tell your program to use custom keys while keeping the camelCase convention.

### Custom decoder
- to flatten the JSON into a single type. This can be done by creating a custom decoder initializer.
```
let account = """
{
    "name": "Capital One",
    "balances": {
        "current": 37103.45,
        "available": 1024.55
    }
}
"""

struct Account: Decodable {
    var name: String
    var currentBalance: Double
    var availableBalance: Double
    
    enum CodingKeys: String, CodingKey {
        case name, balances
    }
    
    enum BalancesCodingKeys: String, CodingKey {
        case currentBalance = "current"
        case availableBalance = "available"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
        let nestedContainer = try container.nestedContainer(keyedBy: BalancesCodingKeys.self, forKey: .balances)
        currentBalance = try nestedContainer.decode(Double.self, forKey: .currentBalance)
        availableBalance = try nestedContainer.decode(Double.self, forKey: .availableBalance)
    }
}
```

### Decoding incoming JSON message to a struct

Example of incoming JSON message:

```
let user = """
{
    "id": 10,
    "full_name": "Donny Wals",
    "is_registered": false,
    "email_address": "address@domain.tld"
}
"""
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
// Convert the string to data
let userData = user.data(using: .utf8)

// Create a JSONDecoder instance to convert a JSON object to a Swift type
let decoder = JSONDecoder()
 
// set the keyDecodingStrategy to convertFromSnakeCase on the jsonDecoder instance
decoder.keyDecodingStrategy = .convertFromSnakeCase
do {
  let user = try decoder.decode(User.self, from: userData)
  print(user)
} catch {
  print(error)
}
```

### Defining a Decodable struct

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

    let data = Data(data.utf8)

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

 Pros: 
 - Unlike NSJSONSerialization, `Codable` simplies the entire process to encode/decode JSON. 
 -  As long as your type conforms to the Codable protocol, together with the new JSONDecoder , you will be able to decode the JSON data into your specified instances.


Create a Loan structure like this:
```
struct Loan: Hashable, Codable {
    var name: String
    var country: String
    var use: String
    var amount: Int
}
```

- We instantiate an instance of JSONDecoder and then convert the JSON string we defined earlier into Data. 
- Call the decode method of the decoder with the JSON data and specify the type of the value to decode (i.e. Loan.self). 
- The decoder will automatically parse the JSON data and convert them into a Loan object.

```
func parseJsonData(data: Data) -> [Loan] {
    var loans = [Loan]()
    let decoder = JSONDecoder()
    do {
    let loanDataStore = try decoder.decode(LoanDataStore.self, from: data) loans = loanDataStore.loans
        } catch {
            print(error)
        }
    return loans
}
```

Console:
```
Loan(name: "John Davis", country: "Peru", use: "to buy a new collection of clothes to stock her shop before the holidays.", amount: 150)
```

#### Working with Custom Property Names

Example of json data:
```
let json = """
{
"name": "John Davis",
"country": "Peru",
"use": "to buy a new collection of clothes to stock her shop before the holidays." ,
"loan_amount": 150
} """
```

- The property name of your type and the key of the JSON data are not exactly matched. We can resolve it by updating the Loan structure:

- In the enum, you define all the property names of your model and their corresponding key in the JSON data. The amount is defined to map to the key loan_amount

```
struct Loan: Hashable, Codable {
    var name: String
    var country: String
    var use: String
    var amount: Int
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case use
        case amount = "loan_amount"
    }
} 
```

#### Working with Nested JSON Objects

Example of nested json data:
```
let json = """
{
"name": "John Davis",
"location": {
    "country": "Peru",
},
"use": "to buy a new collection of clothes to stock her shop before the holidays." ,
"loan_amount": 150
} 
```

How can we decode this type of JSON data and retrieve the value of country from the nested object?

```
struct Loan: Hashable, Codable {
    var name: String
    var country: String
    var use: String
    var amount: Int
    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
}
    enum LocationKeys: String, CodingKey {
        case country
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)

        let location = try values.nestedContainer(keyedBy: LocationKeys.self, forK ey: .country)
        country = try location.decode(String.self, forKey: .country) 
        use = try values.decode(String.self, forKey: .use)
        amount = try values.decode(Int.self, forKey: .amount)
    }
}
```

Resources:
- https://medium.com/swlh/how-to-work-with-json-in-swift-83cd93a837e
- https://www.appcoda.com/json-codable-swift/
- https://www.donnywals.com/an-introduction-to-working-with-codable-in-swift/
