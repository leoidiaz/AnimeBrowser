//
//  AnimeCollectionViewCell.swift
//  AnimeBrowser
//
//  Created by Leonardo Diaz on 4/29/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class AnimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animeImageView: UIImageView!
    // Add updateViews method
    var anime: Anime? {
        didSet{
            guard let anime = anime else {return}
            updateView(anime: anime)
        }
    }
    
    func updateView(anime: Anime){
        AnimeController.fetchImage(anime: anime) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let animeImage):
                    self.animeImageView.image = animeImage
                case .failure(_):
                    print("Error")
                }
            }
        }
        animeImageView.layer.cornerRadius = 10
    }
}
