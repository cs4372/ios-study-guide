//
//  ViewController.swift
//  Download+Cache-Images
//
//  Created by Catherine Shing on 7/25/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    let networker = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        /*
         Make sure self is weak. If the VC were to go out of memory while a network request was happening, the network manager would keep that VC in memory if it had a strong reference to it
         */
        networker.posts(query: "puppies") { [weak self] posts, error in
            if let error = error {
                print("error", error)
                return
            }
            if let posts = posts {
                self?.posts = posts
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
        "cell") as! ImageTableViewCell
        
        let post = posts[indexPath.item]
        
        let representedIdentifier = post.id
        cell.representedIdentifier = representedIdentifier
        cell.image = nil
        cell.badge = nil

        func image(data: Data?) -> UIImage? {
            if let data = data {
                return UIImage(data: data)
            }
            return UIImage(systemName: "picture")
        }
        
        networker.image(post: post) { data, error in
            let img = image(data: data)
            DispatchQueue.main.async {
                // to avoid setting the image on the wrong cell in case the cell has been reused for another item
                print("cell.identifier", representedIdentifier == representedIdentifier)
                if cell.representedIdentifier == representedIdentifier {
                    cell.image = img
                }
            }
        }
        
        networker.profileImage(post: post) { data, error in
            let img = image(data: data)
            DispatchQueue.main.async {
                if cell.representedIdentifier == representedIdentifier {
                    cell.badge = img
                }
            }
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}



