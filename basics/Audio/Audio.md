## Audio

- Use `AVAudioPlayer` class to play audio data from a file/buffer
- It can pause, play, control the volume, panning, rate, looping behavior of the played audio, and so on

Example code:

```
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
    
    @IBAction func adjustVolume(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @IBAction func slide(_ sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
    }
}
```

Resources:
- https://developer.apple.com/documentation/avfaudio/avaudioplayer
- https://www.hackingwithswift.com/example-code/media/how-to-play-sounds-using-avaudioplayer