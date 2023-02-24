## JSON

- text-based, lightweight, and easy way for storing and exchanging data
- used for representing structural data and data exhange in client-server applicationsx
- Since the release of iOS 5 (2011), Apple introduced `NSJSONSerialization` to automatically convert JSON formatted data to objects (OLD)
- Since the release of Swift 4 (2019), Apple introduced the `Codable` protocol together with the new `JSONDecoder` to simplify the whole JSON serialization process (NEW)

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

 ### Codable and JSONDecoder (Preferred WAY)
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