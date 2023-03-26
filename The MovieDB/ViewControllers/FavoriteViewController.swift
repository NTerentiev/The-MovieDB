//
//  FavoriteViewController.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {
    
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
        // Обновление таблицы при загрузке контроллера
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Reload")
        // Обновление таблицы при появлении контроллера на экране
        self.tableView.reloadData()
        getPost()
    }
    
    // Получение сохраненных постов из Realm
    func getPost() {
        // Конвертация набора объектов Realm в массив
        Data.shared.arrayFilm = Array(Save.realm.objects(Post.self))
        // Удаление дубликатов
        Data.shared.arrayFilm = Array(Set(Data.shared.arrayFilm))
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
            // Удаление строки из таблицы
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
