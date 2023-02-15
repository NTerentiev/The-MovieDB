//
//  FavoriteViewController.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    
    var viewModel = TrendsViewModel()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "PriorityDataFilmTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PriorityDataFilmTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Reload")
        self.tableView.reloadData()
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Data.shared.arrayFilm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriorityDataFilmTableViewCell") as! PriorityDataFilmTableViewCell
        cell.configure(with: Data.shared.arrayFilm[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
        Data.shared.arrayFilm.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
}
