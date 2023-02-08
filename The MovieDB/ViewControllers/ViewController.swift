//
//  ViewController.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
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
    
}

