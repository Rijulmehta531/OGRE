//
//  Sounds.swift
//  ogre
//
//  Created by Rijul Mehta on 11/4/23.
//

import SwiftUI
import AVKit
class SoundManager{
    static let instance = SoundManager()
    static var isSoundEnabled:Bool = true
    
    var player: AVAudioPlayer?
    
    enum SoundOption:String{
        case corrrect
        case incorrect
        case quizEnd
        case timer
        case timeEnding
    }
    
    func playSound(sound: SoundOption,fromTime: TimeInterval? = nil){
        if SoundManager.isSoundEnabled{
            guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
            if let startTime = fromTime {
                player?.currentTime = startTime
            }
            do{
                player = try AVAudioPlayer(contentsOf: url)
                // Loop the sound if it's the 'timer' sound
                if sound == .timer {
                    player?.numberOfLoops = -1
                } else {
                    player?.numberOfLoops = 0
                }
                player?.play()
                
            }
            catch let error{
                print("Error playing sound. \(error.localizedDescription)")
            }
        }
    }
    func stopSound() {
            player?.stop()
            player?.currentTime = 0
        }
}

struct Sounds: View {
    
    var body: some View {
        VStack{
            Button("Play sound1"){
                SoundManager.instance.playSound(sound: .timer)
                
            }
            Button("Play sound2"){
                SoundManager.instance.playSound(sound: .incorrect)
            }
        }
    }
}

#Preview {
    Sounds()
}
