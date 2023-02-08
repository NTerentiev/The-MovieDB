//
//  TopModel.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import Foundation
struct TopModel: Codable {
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
}
