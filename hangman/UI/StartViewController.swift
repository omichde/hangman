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
	private let match = MatchController.shared

	override func viewDidLoad() {
		super.viewDidLoad()

		// update counter of players
		match.$playerCount
			.sink { [weak self] pc in
				self?.counterView.text = "\(pc) Players"
			}
			.store(in: &bag)

		// move to matchViewController if game is available
		match.$game
			.sink { [weak self] game in
				guard nil != game, self?.navigationController?.topViewController == self
				else { return }
				
				self?.performSegue(withIdentifier: "showMatch", sender: nil)
			}
			.store(in: &bag)
	}

	@IBAction func unwindToStart(unwindSegue: UIStoryboardSegue) { }

	@IBAction func connect(_ sender: UIBarButtonItem) {
		match.connect()
	}

	@IBAction func start(_ sender: UIBarButtonItem) {
		match.start(wordView.text)
	}
}

extension StartViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		defer {
			match.start(wordView.text)
		}
		return true
	}
}
