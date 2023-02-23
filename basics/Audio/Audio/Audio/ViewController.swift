//
//  ViewController.swift
//  Audio
//
//  Created by Catherine Shing on 2/22/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer() // use this to control our audio
    var timer = Timer()

    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let audioPath = Bundle.main.path(forResource: "beethoven", ofType: "mp3")
        
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            
        }
    }
    
    @IBAction func playMusic(_ sender: UIBarButtonItem) {
        player.prepareToPlay()
          slider.maximumValue = Float(player.duration)
        print(player.duration)
          slider.value = 0.0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
          player.play()
    }
    
    @objc func updateTime(_ timer: Timer) {
        slider.value = Float(player.currentTime)
    }

    @IBAction func stopMusic(_ sender: UIBarButtonItem) {
        player.stop()
        timer.invalidate()
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @IBAction func slide(_ sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
    }
}
