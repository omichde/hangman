//
//  Game+Logic.swift
//  hangman
//
//  Created by Oliver Michalak on 16.06.21.
//

import Foundation


extension Game {

	func guess(_ guess: String) -> Game {
		let text = guess.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
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
			return self.with(guesses: Array(text).map { String($0) })
		}
	}

	func updated() -> Game {
		Game(created: Date(), word: word, guesses: guesses, stepCounter: stepCounter, falseCounter: falseCounter)
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
