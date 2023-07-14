import UIKit

//struct NetworkService {
//    static func request(delay: Double, completion: @escaping () -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//            completion()
//        }
//    }
//}
//
//func add(num: Int, completion: @escaping(Int) -> Void) {
//    NetworkService.request(delay: 1) {
//        completion(num + 3)
//    }
//}
//
//func subtract(num: Int, completion: @escaping(Int) -> Void) {
//    NetworkService.request(delay: 2) {
//        completion(num - 1)
//    }
//}
//
//func multiply(num: Int, completion: @escaping(Int) -> Void) {
//    NetworkService.request(delay: 3) {
//        completion(num * 5)
//    }
//}
//
//func encrypt(num: Int) {
//    subtract(num: num) { subtractedValue in
//        print("Level 1", subtractedValue)
//        multiply(num: subtractedValue) { multipliedValue in
//            print("Level 2", multipliedValue)
//            add(num: multipliedValue) { cipherText in
//                print("The cipherText is: ", cipherText)
//            }
//        }
//    }
//}
//
//encrypt(num: 10)



struct NetworkService {
    static func request(delay: Double) async {
        try? await Task.sleep(nanoseconds: UInt64(delay) * 10000000)
    }
}

func add(num: Int) async -> Int {
    await NetworkService.request(delay: 1)
    return num + 3
}


func subtract(num: Int) async -> Int {
    await NetworkService.request(delay: 10)
    return num - 1
}

func multiply(num: Int) async -> Int {
    await NetworkService.request(delay: 3)
    return num * 5
}

func encrypt(num: Int) {
    Task {
        let subtractedVal = await subtract(num: num)
        print("Level 1", subtractedVal)
        // not going to go to next line until it's done
        let multipliedVal = await multiply(num: subtractedVal)
        print("Level 2", multipliedVal)
        let cipher = await add(num: multipliedVal)
        print("Level 3", cipher)
    }
}
//Task {
//    await encrypt(num: 10)
//}

// Still executed asynchronously. Task is an asynchronous block. Task will take it out of the main thread.
encrypt(num: 6)
print("done")
