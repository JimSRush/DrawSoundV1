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

    
    internal func alterSound(modifiedYPoint: Double) {
        oscillator.frequency = modifiedYPoint
    }
}
