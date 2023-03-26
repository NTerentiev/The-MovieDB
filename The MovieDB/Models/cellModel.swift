//
//  cellModel.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit
import RealmSwift

class Post: Object {
    @objc dynamic var filmImageName: String?
    @objc dynamic var filmName: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var deskription: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var trailer: String?

    convenience init(request result: Results) {
        self.init()
        self.filmImageName = Net.poster + (result.poster_path ?? "")
        self.filmName = result.title ?? result.name ?? ""
        self.releaseDate = (result.release_date ?? result.first_air_date)?.components(separatedBy: "-").first ?? ""
        self.voteAverage = round((result.vote_average ?? 7.2) * 10) / 10
        self.deskription = result.overview
        self.id = result.id ?? 0
        self.trailer = ""
    }
    
    override static func primaryKey() -> String? {
            return "filmName" // Указываем свойство, на которое добавляем уникальный ограничитель
        }
    
    override static func indexedProperties() -> [String] {
           return ["filmName"]
       }
    
}
