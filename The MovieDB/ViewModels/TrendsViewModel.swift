//
//  TrendsViewModel.swift
//  The MovieDB
//
//  Created by Сергей Молодец on 07.02.2023.
//

import Foundation
import Alamofire

class TrendsViewModel {
    var arrayTitleFilm = [Post]()
    
    func getDataMovies(completion: @escaping () -> Void)  {
        AF.request(Net.trending).responseDecodable(of: TopModel.self) { listOfMovies in
            let requestResult = listOfMovies.value?.results ?? []
            self.arrayTitleFilm = requestResult.map{ Post(request: $0) }
            self.arrayTitleFilm = self.arrayTitleFilm.filter{ $0.filmName != nil }
            completion()
        }
    }
        
        func getDataSerials(completion: @escaping () -> Void)  {
            AF.request(Net.serialsTrending).responseDecodable(of: TopModel.self) { listOfSerials in
                let requestResult = listOfSerials.value?.results ?? []
                self.arrayTitleFilm = requestResult.map{ Post(request: $0) }
                self.arrayTitleFilm = self.arrayTitleFilm.filter{ $0.filmName != nil }
                completion()
            }
        }
        
        
        
    }
    
