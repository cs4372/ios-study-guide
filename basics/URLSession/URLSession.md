## URLSession and WebKit View

### WebKit View
- allows developers to load web page url’s inside their apps
-  similar to UIWebView but is more enhanced and powerful than UIWebView

#### Advantages of using WebKit View
- runs on a separate thread => separate memory is allocated to WKWebView, so if it exceeds its memory, then it will only crash the webview but not the app 
- uses latest javascript engine, so renders the page faster compared to the older UIWebView JS engine

### Networking

1. Create a URL
2. Create a URLSession
3. Give URLSession a task
4. Start the task

```
func performRequest(urlString: String) {
    // 1. Create a URL object. If the URL creation is successful, the code proceeds with the rest of the network request code
    if let url = URL(string: urlString) {

        // 2. Create a URLSession to manage network request => provide a way to create tasks, resume them, and handle their results
        let session = URLSession(configuration: .default)

        // 3. Give the session a task and it's responsible for fetching the data from the specified URL
        // completion handler is a closure that will be called when the data task finishes executing.
        let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))

        // 4. Start the task
        task.resume()
    }
}
```

#### Retrieve data from URL using URLSession

```
// Get data from the web
if let url = URL(string: "https://www.google.com") {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
            }
        }
    }.resume()
}
```

```
let url = URL(string: "http://www.stackoverflow.com")!

let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
    guard let data = data else { return }
    print(String(data: data, encoding: .utf8)!)
    // rejoin the main queue and do something about it 
    DispatchQueue.main.sync(execute: {
        //Update UI
    })
}

task.resume()
```
