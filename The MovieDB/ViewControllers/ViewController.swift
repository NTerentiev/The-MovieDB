//
//  ViewController.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "PriorityDataFilmTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PriorityDataFilmTableViewCell")
        }
    }
    
    let viewModel = TrendsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData {
            self.tableView.reloadData()
        }
        
    }
}




//MARK: Settings tableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arrayTitleFilm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityDataFilmTableViewCell") as! PriorityDataFilmTableViewCell
        cell.configure(with: viewModel.arrayTitleFilm[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
    UISwipeActionsConfiguration? {
        let swipeFavourite = UIContextualAction(style: .destructive, title: "Save") { (action, view, completion) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "FavoriteVC") as! FavoriteViewController
            viewController.favoriteFilmArray.append(self.viewModel.arrayTitleFilm[indexPath.row])
            viewController.userDefaults.set(viewController.favoriteFilmArray, forKey: "favoriteFilmArray")
            print ("Save")
            completion(true)
        }
        swipeFavourite.backgroundColor = .purple
        swipeFavourite.image = UIImage(systemName: "star.circle.fill")
        return UISwipeActionsConfiguration(actions: [swipeFavourite])
    }
    
}

