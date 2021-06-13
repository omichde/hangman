//
//  hangmanTests.swift
//  hangmanTests
//
//  Created by Oliver Michalak on 13.06.21.
//

@testable import hangman
import XCTest

class hangmanGameTests: XCTestCase {
	
	func testDateAging() {
		let g1 = Game("test")
		let g2 = g1.guess("a")
		XCTAssertTrue(g1.created < g2.created)
	}
	
	func testDisplayWord() {
		let g1 = Game("")
		XCTAssertTrue(g1.displayWord.isEmpty)
		
		let g2 = Game("abc def")
		XCTAssertEqual(g2.word, "ABC DEF")
		XCTAssertEqual(g2.displayWord, "_ _ _   _ _ _")
		XCTAssertEqual(g2.displayWord.split(separator: " ").count, 6)
	}
	
	func testEmptyGuess() {
		let g1 = Game("abc def")
		let g2 = g1.guess("")
		XCTAssertEqual(g1.guesses, g2.guesses)
		XCTAssertEqual(g1.displayWord, g2.displayWord)
		XCTAssertEqual(g2.displayGuesses, "")
		XCTAssertEqual(g2.stepCounter, 0)
		XCTAssertEqual(g2.falseCounter, 0)
		XCTAssertFalse(g2.isSolved)
	}
	
	func testGuessA() {
		let g1 = Game("abc def aAa")
		
		let g2 = g1.guess("a")
		XCTAssertEqual(g2.displayWord, "A _ _   _ _ _   A A A")
		XCTAssertEqual(g2.displayGuesses, "")
		XCTAssertEqual(g2.stepCounter, 1)
		XCTAssertEqual(g2.falseCounter, 0)
		XCTAssertFalse(g2.isSolved)

		let g3 = g2.guess("A")
		XCTAssertEqual(g3.displayWord, "A _ _   _ _ _   A A A")
		XCTAssertEqual(g3.displayGuesses, "")
		XCTAssertEqual(g3.stepCounter, 1)
		XCTAssertEqual(g3.falseCounter, 0)
		XCTAssertFalse(g3.isSolved)
	}

	func testGuessX() {
		let g1 = Game("abc def aAa")
		
		let g2 = g1.guess("x")
		XCTAssertEqual(g2.displayWord, "_ _ _   _ _ _   _ _ _")
		XCTAssertEqual(g2.displayGuesses, "X")
		XCTAssertEqual(g2.stepCounter, 1)
		XCTAssertEqual(g2.falseCounter, 1)
		XCTAssertFalse(g2.isSolved)

		let g3 = g2.guess("X")
		XCTAssertEqual(g3.displayWord, "_ _ _   _ _ _   _ _ _")
		XCTAssertEqual(g3.displayGuesses, "X")
		XCTAssertEqual(g3.stepCounter, 1)
		XCTAssertEqual(g2.falseCounter, 1)
		XCTAssertFalse(g3.isSolved)
	}

	func testGuessAX() {
		let g1 = Game("abc def aAa")
		
		let g2 = g1.guess("a").guess("X")
		XCTAssertEqual(g2.displayWord, "A _ _   _ _ _   A A A")
		XCTAssertEqual(g2.displayGuesses, "X")
		XCTAssertEqual(g2.stepCounter, 2)
		XCTAssertEqual(g2.falseCounter, 1)
		XCTAssertFalse(g2.isSolved)
	}

	func testGuessAthenBthenC() {
		let g1 = Game("abc def aAa")
		
		let g2 = g1.guess("a").guess("b").guess("c")
		XCTAssertEqual(g2.displayWord, "A B C   _ _ _   A A A")
		XCTAssertEqual(g2.displayGuesses, "")
		XCTAssertEqual(g2.stepCounter, 3)
		XCTAssertEqual(g2.falseCounter, 0)
		XCTAssertFalse(g2.isSolved)
	}
		
	func testGuessABC() {
		let g1 = Game("abc def aAa")

		let g2 = g1.guess("abc")
		XCTAssertEqual(g2.displayWord, "_ _ _   _ _ _   _ _ _")
		XCTAssertEqual(g2.displayGuesses, "")
		XCTAssertEqual(g2.stepCounter, 1)
		XCTAssertEqual(g2.falseCounter, 1)
		XCTAssertFalse(g2.isSolved)
	}

	func testGuessAll() {
		let word = "abc def aAa"
		let g1 = Game(word)

		let g2 = g1.guess(word)
		XCTAssertEqual(g2.displayWord, "A B C   D E F   A A A")
		XCTAssertEqual(g2.displayGuesses, "")
		XCTAssertEqual(g2.stepCounter, 0)
		XCTAssertEqual(g2.falseCounter, 0)
		XCTAssertTrue(g2.isSolved)
	}

	func testGuessAllReversed() {
		let word = "abc def aAa"
		let g1 = Game(word)

		let g2 = g1.guess(String(word.reversed()))
		XCTAssertEqual(g2.displayWord, "_ _ _   _ _ _   _ _ _")
		XCTAssertEqual(g2.displayGuesses, "")
		XCTAssertEqual(g2.stepCounter, 1)
		XCTAssertEqual(g2.falseCounter, 1)
		XCTAssertFalse(g2.isSolved)
	}

	func testGuessAthenAll() {
		let word = "abc def aAa"
		let g1 = Game(word)

		let g2 = g1.guess("a").guess(word)
		XCTAssertEqual(g2.displayWord, "A B C   D E F   A A A")
		XCTAssertEqual(g2.displayGuesses, "")
		XCTAssertEqual(g2.stepCounter, 1)
		XCTAssertEqual(g2.falseCounter, 0)
		XCTAssertTrue(g2.isSolved)
	}

	func testGuessAthenXthenAll() {
		let word = "abc def aAa"
		let g1 = Game(word)

		let g2 = g1.guess("a").guess("X").guess(word)
		XCTAssertEqual(g2.displayWord, "A B C   D E F   A A A")
		XCTAssertEqual(g2.displayGuesses, "X")
		XCTAssertEqual(g2.stepCounter, 2)
		XCTAssertEqual(g2.falseCounter, 1)
		XCTAssertTrue(g2.isSolved)
	}
}
