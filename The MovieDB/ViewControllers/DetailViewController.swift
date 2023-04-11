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
        // Проверяем наличие объекта Post, используя guard let
        guard let post = post else { return }
        
        // Устанавливаем изображение фильма
        imageView.sd_setImage(with: URL(string: post.filmImageName ?? ""))
        // Устанавливаем название фильма
        nameLabel.text = post.filmName
        // Устанавливаем дату выхода фильма
        releaseDateLabel.text = post.releaseDate
        // Устанавливаем среднюю оценку фильма вместе с текстом
        voteAverageLabel.text = "Average: \(post.voteAverage)"
        // Устанавливаем описание фильма
        descriptionLabel.text = post.deskription
        
        // Скрываем видео и отключаем его интерактивность по умолчанию
        playerView.isHidden = true
        playerView.isUserInteractionEnabled = false
        
        // Если у поста есть трейлер
        if !post.trailer!.isEmpty {
            // Загружаем видео с идентификатором трейлера
            playerView.load(withVideoId: post.trailer!)
            // Отображаем видео и включаем его интерактивность
            playerView.isHidden = false
            playerView.isUserInteractionEnabled = true
            // Назначаем делегатом View Controller, реализующий протокол YTPlayerViewDelegate
            playerView.delegate = self
        }
    }
}
