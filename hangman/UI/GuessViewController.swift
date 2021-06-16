//
//  GuessViewController.swift
//  hangman
//
//  Created by Oliver Michalak on 12.06.21.
//

import UIKit


class GuessViewController: UIViewController {
	
	@IBOutlet weak var wordView: UITextField!
	private let match = MatchController.shared

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		wordView.becomeFirstResponder()
	}
}

extension GuessViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let guess = textField.text, !guess.isEmpty else { return false }
		
		defer {
			match.guess(guess)
			dismiss(animated: true, completion: nil)
		}
		return true
	}
}
