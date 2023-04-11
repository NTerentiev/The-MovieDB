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
    
    // Функция для загрузки данных фильмов или сериалов
    private func fetchMedia(with url: String, isSerials: Bool = false, completion: @escaping () -> Void) {
        // Загрузка данных по URL-адресу
        AF.request(url).responseDecodable(of: TopModel.self) { response in
            // Получение результатов запроса
            let results = response.value?.results ?? []
            // Преобразование данных в модели Post и фильтрация
            self.arrayTitleFilm = results.compactMap{ Post(request: $0) }
                .filter{ $0.filmName != nil }
            // Создание диспетчерной группы для синхронизации (
            let dispatchGroup = DispatchGroup()
            // Загрузка трейлеров для каждого элемента массива arrayTitleFilm
            for media in self.arrayTitleFilm {
                dispatchGroup.enter()
                // Формирование URL-адреса для запроса трейлера
                let trailerURL = isSerials ? "\(Net.trailerSerials)\(media.id)\(Net.trailerKeySerials)" : "\(Net.trailer)\(media.id)\(Net.trailerKey)"
                // Загрузка трейлера по URL-адресу
                AF.request(trailerURL).responseDecodable(of: Trailer.self) { response in
                    // Получение результатов запроса
                    let trailers = response.value?.results ?? []
                    // Поиск первого трейлера типа "Trailer" и его сохранение
                    for trailer in trailers where trailer.type == "Trailer" {
                        media.trailer = trailer.key
                        break
                    }
                    // Сигнализация о завершении загрузки трейлера
                    dispatchGroup.leave()
                }
            }
            // Ожидание завершения загрузки всех трейлеров и вызов completion
            dispatchGroup.notify(queue: .main) {
                completion()
            }
        }
    }
    
    // Функция загрузки данных трендовых фильмов
    func getDataMovies(completion: @escaping () -> Void)  {
        fetchMedia(with: Net.trending) {
            completion()
        }
    }
    
    // Функция загрузки данных трендовых сериалов
    func getDataSerials(completion: @escaping () -> Void)  {
        fetchMedia(with: Net.serialsTrending, isSerials: true) {
            completion()
        }
    }
    
    // Функция поиска фильмов
    func searchMovies(query: String, completion: @escaping () -> Void) {
        let searchQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let moviesURL = "\(Net.searchResult)\(searchQuery)\(Net.searchEnd)"
        // Загрузка данных фильмов по URL-адресу с поиском по запросу
        fetchMedia(with: moviesURL) {
            completion()
        }
    }
    
    // Функция отмены поиска фильмов
    func cancelSearch() {
        AF.cancelAllRequests()
    }
}


/*Мы используем DispatchGroup, чтобы ожидать завершения всех асинхронных запросов, перед тем как выполнить какие-либо действия в блоке notify(queue: .main). Каждый раз, когда мы начинаем асинхронный запрос для получения трейлера фильма, мы входим в DispatchGroup, а по завершении запроса, мы выходим из него.
 После того, как все запросы завершатся и все потоки будут возвращены в основную очередь, DispatchGroup вызывает блок notify, в котором мы можем выполнить какие-либо действия, зная, что все запросы завершены. В данном случае, мы вызываем блок completion(), чтобы оповестить контроллер, что данные загружены и можно обновить интерфейс.*/
