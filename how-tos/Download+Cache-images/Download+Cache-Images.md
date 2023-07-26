## How to download and cache images

See ... for reference. 

Key notes:

1. Swift uses URLSession for making network requests and there are two main types of tasks that you can use: download tasks and data tasks.

- Data task is used to fetch data from a url and you receive the entire data of the response such as json Data or images.
- Download task is used to download a file from a url and it's typically for a video, audio, etc.

```
let task = session.downloadTask(with: imageURL) { data, response, error in
...
```

2. Use NSCache to store and manage a collection of NSData objects in memory. Great for caching images and set key as image url and value as image data. It's an Objective C class and we can use Swift strings as keys in an NSCache as long as they are bridged to NSString.

```
var images = NSCache<NSString, NSData>()

....
// find the image in the cache and if it is found, pass it to the completion handler
 if let imageData = self.images.object(forKey: imageURL.absoluteString as NSString) {
    completion(imageData as Data, nil)
    return
}
```

#### Cache the downloaded image data using NSCache
```
  do {
    let data = try Data(contentsOf: data)
    self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
    completion(data, nil)
    } catch let error {
    completion(nil, error)
    }
```

3. Make sure data is displayed correctly in the table/collection cells
- Instead of creating a new cell for each item, the table/collection view reuses cells that have scrolled off the screen to display new items. 
- When a cell is no longer visible, it goes into a reuse pool, and when a new cell is needed, the table view dequeues a cell from the reuse pool

We can set the data of the cell to nil to `reset the cell's content and make sure it doesn't display any previous data when it gets reused`.

```
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ImageTableViewCell
    let post = posts[indexPath.item]
    let representedIdentifier = post.id
    cell.representedIdentifier = representedIdentifier
    cell.image = nil
    cell.badge = nil
```

#### Avoid setting the image on the wrong cell in case the cell has been reused for another item
```
 networker.image(post: post) { data, error in
    let img = image(data: data)
    DispatchQueue.main.async {
        if cell.representedIdentifier == representedIdentifier {
            cell.image = img
        }
    }
}
```