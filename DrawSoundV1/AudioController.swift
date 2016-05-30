import Foundation
import AudioKit

class AudioController {


    //audio
    var fm = AKOscillator()
    var noise = AKPinkNoise(amplitude: 0.005)
    var mixer = AKMixer()
    var fmWithADSR : AKAmplitudeEnvelope!
    var fmWithReverb : AKReverb2!
    var holdDuration = 1.0
    
    init() {
        fm.amplitude = 0.3
        fmWithADSR = AKAmplitudeEnvelope(fm,
                                             attackDuration: 0.1,
                                             decayDuration: 0.1,
                                             sustainLevel: 0.8,
                                             releaseDuration: 0.1)
        
        mixer = AKMixer(fmWithADSR, noise)
        
        fmWithReverb = AKReverb2(mixer, dryWetMix: 0.8)
        
        AudioKit.output = fmWithReverb
        
        AudioKit.start()
        fm.start()
        noise.start()
        
        mixer.start()
        
        fmWithReverb.start()
        
        
        
        
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
