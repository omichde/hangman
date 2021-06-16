//
//  Game+Formatting.swift
//  hangman
//
//  Created by Oliver Michalak on 16.06.21.
//

import Foundation


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
		return trimmedGuess.joined(separator: " ")
	}
	
	enum State {
		case playing, success, failure
	}

	var state: State {
		if falseCounter >= 13 {
			return .failure
		}
		let wordChars = Array(word).map { String($0) }
		if nil == wordChars.firstIndex(where: { !guesses.contains($0) }) {
			return .success
		}
		return .playing
	}
}
