import UIKit

//DispatchQueue.global().async {
//    sleep(2)
//    print("sync: Inside")
//}
//
//print("sync: Outside")

DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)) {
    print("5 seconds")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    print("Delayed by 2 seconds")
}
