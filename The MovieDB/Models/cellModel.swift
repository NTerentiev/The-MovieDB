//
//  cellModel.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit

struct Post {

var filmImageName: URL?
var filmName: String
var releaseDate: String
var genre: String
    
    init(request result: Results) {
        self.filmImageName = URL(string: APIs.poster.rawValue + (result.poster_path ?? "") )
        self.filmName = result.title ?? ""
        self.releaseDate =  result.release_date ?? ""
        self.genre = "later"
    }

}



