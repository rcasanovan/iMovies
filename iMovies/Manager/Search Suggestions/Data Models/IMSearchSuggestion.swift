//
//  IMSearchSuggestion.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation
import RealmSwift

class IMSearchSuggestion: Object {
    @objc dynamic var suggestion: String = ""
    @objc dynamic var timestamp: TimeInterval = NSDate().timeIntervalSince1970
}
