//
//  ViewController.swift
//  URLSession-WebKitView
//
//  Created by Catherine Shing on 2/16/23.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let urlString = "http://www.stackoverflow.com"
//        let request = URLRequest(url: URL(string: urlString)!)
//        self.webView.load(request)
//        self.webView.loadHTMLString("<h1>Hello there<h1>", baseURL: nil)
        
        // Get data from the web
        if let url = URL(string: "https://www.google.com") {
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8)!)
                DispatchQueue.main.sync(execute: {
                    //Update UI
                })
            }
        }
    }
}
