//
//  ViewController.swift
//  Animations
//
//  Created by Catherine Shing on 2/18/23.
//

import UIKit

class ViewController: UIViewController {

    var idx = 0
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let loading_1 = UIImage(named: "frame_0_delay-0.17s.gif")
//        let loading_2 = UIImage(named: "frame_1_delay-0.17s.gif")
//        let loading_3 = UIImage(named: "frame_2_delay-0.17s.gif")
//        let loading_4 = UIImage(named: "frame_3_delay-0.17s.gif")
//
//        let images  = [loading_1!, loading_2!, loading_3!]
//        let animatedImage = UIImage.animatedImage(with: images, duration: 1.0)
//        image.image = animatedImage
    }
    
    @IBAction func clickNext(_ sender: UIButton) {
//        image.image = UIImage(named: "frame_\(idx)_delay-0.17s")
//        idx+=1
//        if idx == 4 {
//            idx = 0
//        }
    }
    
    @IBAction func startAnimation(_ sender: UIButton) {
        if !image.isAnimating {
            let loading_1 = UIImage(named: "frame_0_delay-0.17s.gif")
            let loading_2 = UIImage(named: "frame_1_delay-0.17s.gif")
            let loading_3 = UIImage(named: "frame_2_delay-0.17s.gif")
            let loading_4 = UIImage(named: "frame_3_delay-0.17s.gif")
            

            image.animationImages = [loading_1!, loading_2!, loading_3!, loading_4!]
            image.animationDuration = 1

//            let animatedImage = UIImage.animatedImage(with: images, duration: 1.0)
//            image.image = animatedImage
            image.startAnimating()
        }
    }
    
    @IBAction func stopAnimation(_ sender: UIButton) {
        image.stopAnimating()
    }
}

