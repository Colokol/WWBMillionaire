//
//  Audio.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 01.03.2024.
//

import Foundation

enum Audio: String {
    case win = "win-music"
    case thinking = "zvuk-chasov-vo-vremya-igryi"
    case accepted = "otvet-prinyat-teper-govorit-veduschiy"
    case correctAnswer = "otvet-vernyiy"
    case wrongAnswer = "zvuk-nepravilnogo-otveta"

    var filePath: URL {
        URL(fileURLWithPath: Bundle.main.path(forResource: self.rawValue, ofType: "mp3") ?? "")
    }
}
