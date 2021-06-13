//
//  GuessViewController.swift
//  hangman
//
//  Created by Oliver Michalak on 12.06.21.
//

import UIKit


class GuessViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var wordView: UITextField!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		wordView.becomeFirstResponder()
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let guess = textField.text, !guess.isEmpty else { return false }
		
		defer {
			MatchController.shared.guess(guess)
			dismiss(animated: true, completion: nil)
		}
		return true
	}
}
