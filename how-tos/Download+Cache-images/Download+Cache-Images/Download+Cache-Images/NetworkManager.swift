//
//  NetworkManager.swift
//  Download+Cache-Images
//
//  Created by Catherine Shing on 7/25/23.
//

import Foundation

enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}

fileprivate struct APIResponse: Codable {
  let results: [Post]
}

class NetworkManager {
    
    static var shared = NetworkManager()
    
    // key, value pairs, every time the app fills up with too much memory, it will release some of the memory back to the system
    private var images = NSCache<NSString, NSData>()
    
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    lazy var ACCESS_KEY: String = {
          if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
              if let keys = NSDictionary(contentsOfFile: path) as? [String: Any],
                 let accessKey = keys["AccessKey"] as? String {
                  return accessKey
              }
          }
          return ""
      }()
    
    func components() -> URLComponents {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.unsplash.com"
        return comp
    }
    
    private func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(ACCESS_KEY)", forHTTPHeaderField: "Authorization")
        print("request", request)
        return request
    }
    
    func posts(query: String, completion: @escaping ([Post]?, Error?) -> Void) {
        var comp = components()
        comp.path = "/search/photos"
        comp.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        if let url = comp.url {
            let req = request(url: url)
            let task = session.dataTask(with: req) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                    completion(nil, NetworkManagerError.badResponse(response))
                    return
                }
                guard let data = data else {
                    completion(nil, NetworkManagerError.badData)
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(response.results, nil)
                } catch let error {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
        
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = session.downloadTask(with: imageURL) { data, response, error in
            if let imageData = self.images.object(forKey: imageURL.absoluteString as NSString) {
                completion(imageData as Data, nil)
                return
            }
            
            if let error = error {
                print("error", error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }
            guard let data = data else {
                completion(nil, NetworkManagerError.badData)
                return
            }
            
            do {
                let data = try Data(contentsOf: data)
                self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func image(post: Post, completion: @escaping
               (Data?, Error?) -> (Void)) {
        if let imageURL = post.urls.regular {
            let url = URL(string: imageURL)!
            download(imageURL: url, completion: completion)
        }
    }
    
    func profileImage(post: Post, completion: @escaping (Data?, Error?) -> Void) {
        if let imageURL = post.user.profile_image.medium {
            let url = URL(string: imageURL)!
            download(imageURL: url, completion: completion)
        }
    }
}
