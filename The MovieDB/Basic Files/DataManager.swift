//
//  DataManager.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 13.02.2023.
//

import UIKit
import RealmSwift

class Data {
    static let shared = Data()
    var arrayFilm = [Post]()
    

//    private let realm = try? Realm()
//    
//    func save() {
//        let post = Data.shared.arrayFilm
//        
//        try? realm?.write {
//            realm?.add(post, update: .all)
//        }
//    }
    
    
}
