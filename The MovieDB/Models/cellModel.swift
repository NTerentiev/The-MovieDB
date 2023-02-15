//
//  cellModel.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit
import RealmSwift

struct Post: Hashable {

var filmImageName: URL?
var filmName: String?
var releaseDate: String?
var voteAverage: Double
    
    init(request result: Results) {
        self.filmImageName = URL(string: Net.poster + (result.poster_path ?? "") )
        if result.title == nil {
            self.filmName = result.name
        } else { self.filmName = result.title
        }
//        self.filmName = result.title
        if result.release_date == nil {
            self.releaseDate = result.first_air_date?.components(separatedBy: "-").first! ?? ""
        } else {
            self.releaseDate = result.release_date?.components(separatedBy: "-").first! ?? ""
        }
        self.voteAverage = round((result.vote_average ?? 7.2) * 10)/10
    }

}



//first_air_date
