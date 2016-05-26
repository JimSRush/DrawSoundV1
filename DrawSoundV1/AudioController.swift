import Foundation
import AudioKit

class AudioController {


    //audio
    let oscillator = AKOscillator()
    
    
    init() {
        oscillator.amplitude = 0.3
        AudioKit.output = oscillator
        AudioKit.start()
        oscillator.start()
    }

//    let two = Double (fromPoint.y * 27.5)
//    oscillator.frequency = two

}
