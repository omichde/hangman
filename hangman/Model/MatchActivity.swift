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
		meta.title = "Hangman Match"
		meta.type = .generic
		return meta
	}
}
