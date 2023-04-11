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
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        guard let post = post else { return }
        // Настройка scrollView
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = #colorLiteral(red: 0.08178392798, green: 0.04853864014, blue: 0.1759224534, alpha: 1)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        // Создание containerView для хранения всех subviews
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        
        // Настройка constraints containerView
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // Настройка постера
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_setImage(with: URL(string: post.backdropPath ?? ""))
        containerView.addSubview(imageView)
        
        // Настройка constraints постаре
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.33).isActive = true
        
        // Настройка имени фильма
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "\(post.filmName!) (\(post.releaseDate!))"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .left
        containerView.addSubview(nameLabel)
        
        // Настройка constraints имени фильма
        nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16).isActive = true
        
        // Настройка средней оценки фильма
        let voteAverageLabel = UILabel()
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLabel.text = "Rating: \(post.voteAverage)"
        voteAverageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        containerView.addSubview(voteAverageLabel)
        
        // Настройка constraints средней оценки фильма
        voteAverageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        voteAverageLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        
        // Настройка описания фильма
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = post.deskription
        descriptionLabel.numberOfLines = 0
        containerView.addSubview(descriptionLabel)
        
        // Настройка constraints описания фильма
        descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        
        // Настройка playerView
        let playerView = YTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        // Если у поста есть трейлер
        if !post.trailer!.isEmpty {
            playerView.load(withVideoId: post.trailer!)
            print("Loading video with ID: \(post.trailer!)")
            playerView.isHidden = false
            playerView.isUserInteractionEnabled = true
            playerView.delegate = self
        } else {
            print("No video ID found for this post")
            playerView.isHidden = true
            playerView.isUserInteractionEnabled = false
        }
        containerView.addSubview(playerView)
        // Настройка constraints playerView
        playerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        playerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.33).isActive = true
    }
    
}
