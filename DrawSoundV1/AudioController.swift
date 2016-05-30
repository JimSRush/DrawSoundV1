import Foundation
import AudioKit

class AudioController {


    //audio
    var fm = AKOscillator()
    var fmWithADSR : AKAmplitudeEnvelope!
    var holdDuration = 1.0
    
    init() {
        fmWithADSR = AKAmplitudeEnvelope(fm,
                                             attackDuration: 0.1,
                                             decayDuration: 0.1,
                                             sustainLevel: 0.8,
                                             releaseDuration: 0.1)
        
        
        AudioKit.output = fmWithADSR
        AudioKit.start()
        fm.start()
        //fmWithADSR.start()
    }
    
    internal func playSound() {
        fmWithADSR.start()
        
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.stop()
        }
        
        
    }
    
    func stop() {
        fmWithADSR.stop()
    }

    
    internal func alterSound(modifiedYPoint: Double) {
        fm.frequency = modifiedYPoint
    }
}
