//
//  Genres.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import Foundation
struct Genres : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

}
