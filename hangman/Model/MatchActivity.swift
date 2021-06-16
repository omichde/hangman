//
//  MatchActivity.swift
//  hangman
//
//  Created by Oliver Michalak on 12.06.21.
//

import Foundation
import GroupActivities

struct MatchActivity: GroupActivity {
	
	var metadata: GroupActivityMetadata {
		var meta = GroupActivityMetadata()
		meta.title = "Hangman Game"
		meta.subtitle = "Let's play a simple hangman, finding a word by guessing a single character or the word altogether."
		meta.type = .generic
		return meta
	}
}
