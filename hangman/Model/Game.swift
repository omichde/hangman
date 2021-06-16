//
//  Game.swift
//  hangman
//
//  Created by Oliver Michalak on 12.06.21.
//

import Foundation


struct Game: Codable {
	let created: Date
	let word: String
	let guesses: [String]
	let stepCounter: Int
	let falseCounter: Int
}

extension Game {
	init(_ word: String) {
		self.created = Date()
		self.word = word.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		self.guesses = []
		self.stepCounter = 0
		self.falseCounter = 0
	}
}
