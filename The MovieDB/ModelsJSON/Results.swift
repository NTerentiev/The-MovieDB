//
//  Results.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import Foundation
struct Results : Codable {
    let backdrop_path : String?
    let id : Int?
    let title : String?
    let original_language : String?
    let original_title : String?
    let overview : String?
    let poster_path : String?
    let media_type : String?
    let genre_ids : [Int]?
    let popularity : Double?
    let release_date : String?
    let vote_average : Double?
    let vote_count : Int?

    enum CodingKeys: String, CodingKey {

        case backdrop_path = "backdrop_path"
        case id = "id"
        case title = "title"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case poster_path = "poster_path"
        case media_type = "media_type"
        case genre_ids = "genre_ids"
        case popularity = "popularity"
        case release_date = "release_date"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }

}

