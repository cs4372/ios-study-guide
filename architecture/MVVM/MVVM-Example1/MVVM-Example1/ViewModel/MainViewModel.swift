//
//  MainViewModel.swift
//  MVVM-Example1
//
//  Created by Catherine Shing on 6/22/23.
//

import Foundation

/*
 - view model is responsible for providing the necessary data and logic to the view
 - provides methods and properties that the View can interact with.
 */
class MainViewModel {
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        10
    }
    
    func getData() {
        APICaller.getTrendingMovies { result in
            switch result {
            case .success(let data):
                print("Top Trending counts: \(data.results.count)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
