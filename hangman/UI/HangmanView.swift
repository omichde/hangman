//
//  HangmanView.swift
//  hangman
//
//  Created by Oliver Michalak on 13.06.21.
//

import UIKit


class HangmanView: UIView {
	var steps: Int = 0 { didSet { setNeedsDisplay() } }

	override func draw(_ rect: CGRect) {
		HangmanKit.drawHangman(frame: rect, resizing: .aspectFill, strokeColor: .brown, progress: Double(steps))
	}
}
