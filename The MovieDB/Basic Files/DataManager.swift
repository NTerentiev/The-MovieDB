//
//  DataManager.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 13.02.2023.
//

import UIKit

class Data {
    static let shared = Data()
    
    var arrayFilm = [Post]()
    
    private init() {}
}
