//
//  Petition.swift
//  Project7
//
//  Created by user on 28/07/21.
//

import Foundation
//create new Petition instances by passing in values for title, body, and signatureCount.
struct Petition: Codable { //Petition struct contains two strings and an integer, all of which conforms to Codable already
    var title: String
    var body: String
    var signatureCount: Int
}
