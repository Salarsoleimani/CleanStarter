//
//  SoundEffects.swift
//  ListHub
//
//  Created by Salar Soleimani on 2020-04-14.
//  Copyright © 2020 BEKSAS. All rights reserved.
//

import Foundation
import AudioToolbox
import Domain
import AVFoundation

public struct AppSoundEffects {
  public init() {}
  public func playPopSound() {
    play(url: AppEffectSoundsType.splash())
  }
  public func playErrorSound() {
    play(url: AppEffectSoundsType.error())
  }
  public func play(soundName: String, soundFormat: String, numberOfLoops: Int) {
    var audioPlayer = AVAudioPlayer()
    guard let audioFileURL = Bundle.main.url(forResource: soundName, withExtension: soundFormat) else { return }
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
    } catch let err {
      print("error on set the audio player: \(err)")
    }
    audioPlayer.numberOfLoops = numberOfLoops
    audioPlayer.prepareToPlay()
    audioPlayer.play()
  }
  private func play(url: URL) {
    var sound: SystemSoundID = 0
    AudioServicesCreateSystemSoundID(url as CFURL, &sound)
    AudioServicesPlaySystemSound(sound)
  }
}

fileprivate enum AppEffectSoundsType {
  public static let splash = { return Bundle.main.url(forResource: "SplashSound", withExtension: "mp3")!}
  public static let error = { return Bundle.main.url(forResource: "ErrorSound", withExtension: "mp3")!}
}
