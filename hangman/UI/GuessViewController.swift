//
//  GuessViewController.swift
//  hangman
//
//  Created by Oliver Michalak on 12.06.21.
//

import UIKit
import Combine


class GuessViewController: UIViewController {
	
	@IBOutlet weak var wordView: UITextField!

	private var bag = Set<AnyCancellable>()
	private let match = MatchController.shared

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	
		match.$game.sink { [weak self] game in
			guard let self = self else { return }
			
			if game == nil {
				self.performSegue(withIdentifier: "unwindToStart", sender: nil)
			}
		}.store(in: &bag)

		wordView.becomeFirstResponder()
	}
}

extension GuessViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let guess = textField.text, !guess.isEmpty else { return false }
		
		defer {
			async {
				await match.guess(guess)
			}
			dismiss(animated: true, completion: nil)
		}
		return true
	}
}
