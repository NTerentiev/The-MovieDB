//
//  FavoriteViewController.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit
import RealmSwift
import Lottie

class FavoriteViewController: UIViewController {
    
    private var animationView: LottieAnimationView?
    
    // ViewModel для представления трендов фильмов
    var viewModel = TrendsViewModel()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            // Регистрация ячейки для таблицы
            let nib = UINib(nibName: "PriorityDataFilmTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PriorityDataFilmTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Обновление таблицы при появлении контроллера на экране
        self.tableView.reloadData()
        getPost()
        
    }
    
    // Получение сохраненных постов из Realm
    func getPost() {
        // Конвертация набора объектов Realm в массив
        Data.shared.arrayFilm = Array(Save.realm.objects(Post.self))
        // Управление анимацией
        Data.shared.arrayFilm.isEmpty ? showEmptyTableMessage() : (tableView.backgroundView = nil)
        // Удаление дубликатов
        Data.shared.arrayFilm = Array(Set(Data.shared.arrayFilm))
    }
    
    func showEmptyTableMessage() {
        // Создаем анимацию и добавляем на задний фон таблицы
        animationView = .init(name: "emptyBox")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        tableView.backgroundView = animationView
        animationView!.play()
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    // Количество ячеек таблицы равно количеству сохраненных фильмов
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Data.shared.arrayFilm.count
    }
    
    // Настройка ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityDataFilmTableViewCell", for: indexPath) as! PriorityDataFilmTableViewCell
        cell.configure(with: Data.shared.arrayFilm[indexPath.row])
        return cell
    }
    
    // Обработка удаления ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Удаление сохраненного фильма из Realm
            try! Save.realm.write {
                Save.realm.delete(Data.shared.arrayFilm[indexPath.row])
            }
            print("Deleted")
            // Удаление сохраненного фильма из массива
            Data.shared.arrayFilm.remove(at: indexPath.row)
            Data.shared.arrayFilm.isEmpty ? showEmptyTableMessage() : (tableView.backgroundView = nil)
            // Удаление строки из таблицы
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.post = Data.shared.arrayFilm[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
