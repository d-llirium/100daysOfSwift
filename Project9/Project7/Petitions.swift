//
//  Petitions.swift
//  Project7
//
//  Created by user on 28/07/21.
//

import Foundation
//matches exactly how the JSON looks: the main JSON contains the results array, and each item in that array is a Petition.
struct Petitions: Codable {
    var results: [Petition]//our array of petitions actually comes inside a dictionary called “results”
}
