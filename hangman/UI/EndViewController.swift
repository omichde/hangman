//
//  SuccessViewController.swift
//  hangman
//
//  Created by Oliver Michalak on 13.06.21.
//

import UIKit
import AVKit


class EndViewController: UIViewController {
	
	@IBOutlet weak var wordView: UILabel!
	private let match = MatchController.shared
	private lazy var sound: AVAudioPlayer? = {
		let win = (match.game?.state == .success)
		guard let url = Bundle.main.url(forResource: win ? "success" : "error", withExtension: "wav"),
					let sound = try? AVAudioPlayer(contentsOf: url, fileTypeHint: nil)
		else { return nil }
		sound.prepareToPlay()
		return sound
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		wordView.text = match.game?.word
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		sound?.play()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)

		match.end()
	}
}
