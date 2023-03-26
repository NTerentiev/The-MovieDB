//
//  Trailer.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 20.02.2023.
//

import Foundation

// MARK: - Youtube
struct Trailer: Codable {
    let id: Int
    let results: [Trailers]
}

// MARK: - Result
struct Trailers: Codable {
    let iso639_1: ISO639_1
    let iso3166_1: ISO3166_1
    let name, key: String
    let site: Site
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

enum ISO3166_1: String, Codable {
    case us = "US"
}

enum ISO639_1: String, Codable {
    case en = "en"
}

enum Site: String, Codable {
    case youTube = "YouTube"
}

enum TypeEnum: String, Codable {
    case behindTheScenes = "Behind the Scenes"
    case featurette = "Featurette"
    case teaser = "Teaser"
    case trailer = "Trailer"
}
