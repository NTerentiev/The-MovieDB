//
//  Constans.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 07.02.2023.
//

import Foundation
import RealmSwift

struct Save {
    static let realm = try! Realm()
}

struct Net {
    static let poster = "https://image.tmdb.org/t/p/w500"
    static let trending = "https://api.themoviedb.org/3/trending/movie/week?api_key=9a38c77ca1d83d403ed1655c32ecefa3"
    static let serialsTrending = "https://api.themoviedb.org/3/trending/tv/week?api_key=9a38c77ca1d83d403ed1655c32ecefa3"
    
    static let trailer = "https://api.themoviedb.org/3/movie/"
    static let trailerKey = "/videos?api_key=9a38c77ca1d83d403ed1655c32ecefa3&language=en-US"
    
    static let trailerSerials = "https://api.themoviedb.org/3/tv/"
    static let trailerKeySerials = "/videos?api_key=9a38c77ca1d83d403ed1655c32ecefa3&language=en-US"
    
    static let searchResult = "https://api.themoviedb.org/3/search/movie?api_key=9a38c77ca1d83d403ed1655c32ecefa3&language=en-US&query="
    static let searchEnd = "&page=1&include_adult=false"
}

