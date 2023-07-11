import UIKit
import Combine

final class LevelsManager {
    
    var level: Int = 0 {
        didSet {
            print("User's current level \(level)")
        }
    }
}

let lvlsManager = LevelsManager()
let lvlsRange = (0...100)
let cancellable = lvlsRange
    .publisher
    .assign(to: \.level, on: lvlsManager)
