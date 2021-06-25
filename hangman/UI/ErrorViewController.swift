//
//  ErrorViewController.swift
//  hangman
//
//  Created by Oliver Michalak on 13.06.21.
//

import UIKit


class ErrorViewController: UIViewController {
	
	@IBOutlet weak var wordView: UILabel!
	private let match = MatchController.shared
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		wordView.text = match.game?.word
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	
		match.end()
	}
}
