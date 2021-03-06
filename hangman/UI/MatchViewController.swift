//
//  GameViewController.swift
//  hangman
//
//  Created by Oliver Michalak on 12.06.21.
//

import UIKit
import Combine


class MatchViewController: UIViewController {

	@IBOutlet weak var wordView: UILabel!
	@IBOutlet weak var guessView: UILabel!
	@IBOutlet weak var hangmanView: HangmanView!

	private var bag = Set<AnyCancellable>()
	private let match = MatchController.shared

	override func viewDidLoad() {
		super.viewDidLoad()
		
		match.$game.sink { [weak self] game in
			guard let self = self else { return }
			
			if let game = game {
				self.viewUpdate(game: game)
				switch game.state {
				case .success: self.performSegue(withIdentifier: "showSuccess", sender: nil)
				case .failure: self.performSegue(withIdentifier: "showError", sender: nil)
				default: ()
				}
			}
			else {
				self.performSegue(withIdentifier: "unwindToStart", sender: nil)
			}
		}.store(in: &bag)

		if let game = match.game {
			viewUpdate(game: game)
		}
	}

	func viewUpdate(game: Game) {
		wordView.text = game.displayWord
		guessView.text = game.displayGuesses
		hangmanView.steps = game.falseCounter
	}
	
	@IBAction func update(_ sender: UIBarButtonItem) {
		match.update()
	}
}
