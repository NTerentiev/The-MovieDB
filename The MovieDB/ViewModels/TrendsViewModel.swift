//
//  TrendsViewModel.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 07.02.2023.
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
            for film in self.arrayTitleFilm {
                AF.request(Net.trailer + "\(film.id)" + Net.trailerCont).responseDecodable(of: Trailer.self) { listOfTrailers in
                    let request = listOfTrailers.value?.results
                    for tr in request ?? [] {
                        if tr.type == "Trailer" {
                            film.trailer = tr.key
                        }
                    }
                    completion()
                }
            }
            completion()
        }
    }
    
    func getDataSerials(completion: @escaping () -> Void)  {
        AF.request(Net.serialsTrending).responseDecodable(of: TopModel.self) { listOfSerials in
            let requestResult = listOfSerials.value?.results ?? []
            self.arrayTitleFilm = requestResult.map{ Post(request: $0) }
            self.arrayTitleFilm = self.arrayTitleFilm.filter{ $0.filmName != nil }
            for film in self.arrayTitleFilm {
                AF.request(Net.trailer + "\(film.id)" + Net.trailerCont).responseDecodable(of: Trailer.self) { listOfTrailers in
                    let request = listOfTrailers.value?.results
                    for tr in request ?? [] {
                        if tr.type == "Trailer" {
                            film.trailer = tr.key
                        }
                    }
                    completion()
                }
            }
            completion()
        }
    }
    
    // Получение списка видео для данного фильма
//    viewModel.movieVideos(for: movieId) { result in
//        switch result {
//        case .success(let videos):
//            // Поиск видео с названием "Official Trailer"
//            if let trailer = videos.first(where: { $0.name == "Official Trailer" }) {
//                // Создание ссылки на видео
//                let videoUrlString = "https://www.youtube.com/watch?v=\(trailer.key)"
//            }
//        }
//    }
    
}

