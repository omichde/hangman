//
//  ViewController.swift
//  hangman
//
//  Created by Oliver Michalak on 12.06.21.
//

import UIKit
import Combine

class StartViewController: UIViewController {

	@IBOutlet weak var wordView: UITextField!
	@IBOutlet weak var counterView: UILabel!

	private var bag = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()

		// update counter of players
		MatchController.shared.$playerCount
			.sink { [weak self] pc in
				self?.counterView.text = "\(pc) Players"
			}
			.store(in: &bag)

		// move to matchViewController if game is available
		MatchController.shared.$game
			.sink { [weak self] game in
				guard nil != game, self?.navigationController?.topViewController == self
				else { return }
				
				self?.performSegue(withIdentifier: "showMatch", sender: nil)
			}
			.store(in: &bag)
	}

	@IBAction func connect(_ sender: UIBarButtonItem) {
		MatchController.shared.connect()
	}

	@IBAction func start(_ sender: UIBarButtonItem) {
		guard let word = wordView.text, !word.isEmpty else { return }
		
		MatchController.shared.next(Game(word))
	}
}

