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

	func guess(_ guess: String) -> Game {
		let text = guess.uppercased()
		guard !text.isEmpty else { return self }

		// if single char append to guess
		if text.count == 1 {
			guard nil == guesses.firstIndex(of: text) else { return self }	// ignore accidental repeated char

			var guesses = guesses
			guesses.append(text)
			var game = self.with(guesses: guesses).increasedStepper()
			if !word.contains(text) {
				game = game.increasedFalse()
			}
			return game
		}
		else {	// test against word
			guard word == text else {
				return self.increasedStepper().increasedFalse()
			}
			
			// found it
			var guesses = guesses
			guesses.append(contentsOf: Array(text).map { String($0) })
			guesses = Array(Set(guesses))
			return self.with(guesses: guesses)
		}
	}
	
	private func with(guesses: [String]) -> Game {
		Game(created: Date(), word: word, guesses: guesses, stepCounter: stepCounter, falseCounter: falseCounter)
	}

	private func increasedStepper() -> Game {
		Game(created: Date(), word: word, guesses: guesses, stepCounter: stepCounter + 1, falseCounter: falseCounter)
	}

	private func increasedFalse() -> Game {
		Game(created: Date(), word: word, guesses: guesses, stepCounter: stepCounter, falseCounter: falseCounter + 1)
	}
}

extension Game {
	var displayWord: String {
		var result = [String]()
		for chr in Array(word).map({ String($0) }) {
			if guesses.contains(chr) {
				result.append(chr)
			}
			else if chr == " " {
				result.append(" ")
			}
			else {
				result.append("_")
			}
		}
		return result.joined(separator: " ")
	}

	var displayGuesses: String {
		let wordChars = Array(word).map { String($0) }
		let trimmedGuess = guesses.filter { !wordChars.contains($0) }
		return trimmedGuess.joined(separator: ", ")
	}
	
	var isSolved: Bool {
		let wordChars = Array(word).map { String($0) }
		return nil == wordChars.firstIndex { !guesses.contains($0) }
	}
}
