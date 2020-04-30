//
//  DetailViewController.swift
//  AnimeBrowser
//
//  Created by Leonardo Diaz on 4/29/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    //MARK: - Properties
    
    var anime: Anime?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        animeImageView.layer.cornerRadius = 10
    }
    
    
    private func updateView() {
        guard let anime = anime else { return }
        titleLabel.text = anime.title.lowercased().capitalized
        typeLabel.text = "Type: \(anime.type.lowercased().capitalized)"
        AnimeController.fetchImage(anime: anime) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let animeImage):
                    self.animeImageView.image = animeImage
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
        if let startDate = anime.startDate {
            startDateLabel.text = "Start Date: \(startDate)"
        } else {
            startDateLabel.text = "Start Date: Unknown"
        }
    }
    
}
