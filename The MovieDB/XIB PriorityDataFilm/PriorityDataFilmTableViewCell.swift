//
//  PriorityDataFilmTableViewCell.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 06.02.2023.
//

import UIKit
import SDWebImage

class PriorityDataFilmTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    var id = 0
    var trailer = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with post: Post) {
        filmImage.sd_setImage(with: URL(string: post.filmImageName ?? ""))
        filmImage.clipsToBounds = true
        voteAverage.text = "Rating: \(post.voteAverage)"
        filmName.text = post.filmName
        releaseDate.text = "(\(post.releaseDate ?? ""))"
        id = post.id
        trailer = post.trailer ?? ""
    }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
        
        
        
    
}
