//
//  ViewController.swift
//  async-await-completion-handlers
//
//  Created by Catherine Shing on 8/23/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//
//        JsonAPI().loadPosts { result in
//            switch result {
//            case .success(let postArray):
//                print(postArray)
//            case .failure(let error):
//                print(error)
//
//            }
//        }
        Task {
            do {
                let posts = try await JsonAPI.loadPostsAsync()
                print(posts)
            } catch {
                print(error)
            }
        }

    }
}
