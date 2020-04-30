//
//  AnimeCollectionViewCell.swift
//  AnimeBrowser
//
//  Created by Leonardo Diaz on 4/29/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class AnimeCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets
    @IBOutlet weak var animeImageView: UIImageView!
    //MARK: - Properties
    var anime: Anime? {
        didSet{
            updateViewWithTopAnime()
        }
    }
    
    var search: Anime? {
        didSet{
            updateViewWithSearch()
        }
    }
    
    //MARK: - Private Methods
    func updateViewWithTopAnime(){
        guard let anime = anime else {return }
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
    
    func updateViewWithSearch(){
        guard let search = search else { return }
        AnimeController.fetchImage(anime: search) { (result) in
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
