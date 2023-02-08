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
    @IBOutlet weak var genre: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with post: Post) {
        filmImage.sd_setImage(with: post.filmImageName)
        filmImage.clipsToBounds = true
        genre.text = post.genre
        filmName.text = post.filmName
        releaseDate.text = post.releaseDate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
