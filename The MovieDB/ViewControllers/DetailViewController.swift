//
//  DetailViewController.swift
//  The MovieDB
//
//  Created by Никита Терентьев on 16.02.2023.
//

import UIKit
import SDWebImage
import YouTubeiOSPlayerHelper

class DetailViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        if let post = post {
            imageView.sd_setImage(with: URL(string: post.filmImageName ?? ""))
            nameLabel.text = post.filmName
            releaseDateLabel.text = post.releaseDate
            voteAverageLabel.text = "Average: \(String(post.voteAverage))"
            descriptionLabel.text = post.deskription
            if post.trailer != "" {
                // загружаем видео, если есть идентификатор
                playerView.load(withVideoId: post.trailer!)
                playerView.isHidden = false
                playerView.isUserInteractionEnabled = true
                playerView.delegate = self
            } else {
                // скрываем видео, если идентификатор отсутствует
                playerView.isHidden = true
                playerView.isUserInteractionEnabled = false
            }
        }
    }
}
