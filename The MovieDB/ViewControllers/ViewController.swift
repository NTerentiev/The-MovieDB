//
//  ViewController.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit
import SDWebImage
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            // Регистрация ячейки в таблице
            let nib = UINib(nibName: "PriorityDataFilmTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PriorityDataFilmTableViewCell")
        }
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let viewModel = TrendsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Получение данных фильмов
        viewModel.getDataMovies {
            self.tableView.reloadData()
        }
    }
    
    // Обработка нажатия на Segmented Control
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        viewModel.arrayTitleFilm.removeAll()
        sender.selectedSegmentIndex == 0 ? viewModel.getDataMovies { self.tableView.reloadData() } : viewModel.getDataSerials { self.tableView.reloadData()
        }
    }
 }




// Настройка TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Количество ячеек в TableView
        viewModel.arrayTitleFilm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Настройка ячейки в TableView
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityDataFilmTableViewCell") as! PriorityDataFilmTableViewCell
        cell.configure(with: viewModel.arrayTitleFilm[indexPath.row])
        return cell
    }
    
    // Обработка свайпа по ячейке в TableView
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeFavourite = UIContextualAction(style: .destructive, title: "Save") { (action, view, completion) in
            // Добавление объекта в массив любимых фильмов
            Data.shared.arrayFilm.append(self.viewModel.arrayTitleFilm[indexPath.row])
            Data.shared.arrayFilm = Array(Set(Data.shared.arrayFilm))
            // Сохранение объекта в базу данных Realm
            try! Save.realm.write {
                Save.realm.add(Data.shared.arrayFilm, update: .modified)
            }
            print ("Save")
            completion(true)
        }
        swipeFavourite.backgroundColor = .purple
        swipeFavourite.image = UIImage(systemName: "star.circle.fill")
        return UISwipeActionsConfiguration(actions: [swipeFavourite])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.post = viewModel.arrayTitleFilm[indexPath.row]
          navigationController?.pushViewController(detailVC, animated: true)

    }
    
    
}

extension ViewController: UISearchBarDelegate, UIGestureRecognizerDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovies(query: searchText) {
            self.tableView.reloadData()
        }
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text == "" {
            viewModel.cancelSearch()
            viewModel.getDataMovies {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.text = ""
         viewModel.cancelSearch()
         viewModel.getDataMovies {
             self.tableView.reloadData()
         }
        searchBar.resignFirstResponder()
     }
    
}
