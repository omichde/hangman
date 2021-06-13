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
	@IBOutlet weak var countView: UILabel!

	private var bag = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		MatchController.shared.$game.sink { [weak self] game in
			guard let self = self, let game = game else { return }

			self.viewUpdate(game: game)
		}.store(in: &bag)

		if let game = MatchController.shared.game {
			viewUpdate(game: game)
		}
	}

	func viewUpdate(game: Game) {
		wordView.text = game.displayWord
		guessView.text = game.displayGuesses
		countView.text = "\(game.falseCounter) - \(game.stepCounter)"
	}

	@IBAction func dismiss(_ sender: UIBarButtonItem) {
		navigationController?.popViewController(animated: true)
		// open what happens to game
	}
}
