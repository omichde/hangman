//
//  MatchController.swift
//  hangman
//
//  Created by Oliver Michalak on 12.06.21.
//

import Foundation
import GroupActivities
import Combine


class MatchController {
	
	static var shared = MatchController()

	@Published var game: Game?
	@Published var playerCount: Int = 0
	
	private var session: GroupSession<MatchActivity>?
	private var messenger: GroupSessionMessenger?
	private var bag = Set<AnyCancellable>()
	private var tasks = Set<Task.Handle<Void, Never>>()

	init() {
		async {
			for await session in MatchActivity.sessions() {
				reset()
				self.session = session
				session.join()

				session.$state.sink { [weak self] state in
					if case .invalidated = state {
						self?.reset()
					}
				}.store(in: &bag)

				session.$activeParticipants
					.receive(on: DispatchQueue.main)
					.sink { [weak self] participants in
					self?.playerCount = participants.count
				}.store(in: &bag)

				// receive Game messages
				let messenger = GroupSessionMessenger(session: session)
				self.messenger = messenger
				let task = detach { [weak self] in
					guard let self = self else { return }

					for await (game, _) in messenger.messages(of: Game.self) {
						// check for newer game
						guard self.game == nil || self.game!.created <= game.created else { return }

						DispatchQueue.main.async {	// meh
							self.game = game
						}
					}
				}
				tasks.insert(task)
			}
		}
	}

	func connect() {
		async {
			let activity = MatchActivity()
			switch await activity.prepareForActivation() {
			case .activationPreferred:
				activity.activate()
			default:
				reset()
			}
		}
	}

	func start(_ word: String?) {
		guard
			let word = word,
			!word.isEmpty,
			playerCount > 0
		else { return }
		
		next(Game(word))
	}

	func reset() {
		DispatchQueue.main.async { [weak self] in	// meh
			guard let self = self else { return }

			self.bag.removeAll()
			self.tasks.forEach { $0.cancel() }
			self.tasks = []
//			self.session?.leave() // needs testing
//			self.session = nil
			self.messenger = nil
			self.game = nil
			self.playerCount = 0
		}
	}
}

extension MatchController {

	func next(_ game: Game) {
		async {
			do {
				DispatchQueue.main.async { [weak self] in	// meh
					self?.game = game
				}
				try await messenger?.send(game)
			}
			catch {
				print("error on game sent: \(error)")
			}
		}
	}
	
	func guess(_ guess: String) {
		guard let game = game else { return }

		next(game.guess(guess))
	}
}
