//
//  Sound.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 01.03.2024.
//

import AVFoundation

final class Sound {
    private var player: AVAudioPlayer!
    static let shared = Sound()

    func play(_ audio: Audio) {
        do {
            player = try AVAudioPlayer(contentsOf: audio.filePath)
            player.play()
        } catch {
            print(error.localizedDescription)
        }
    }

    func stop() {
        player.stop()
    }
}
