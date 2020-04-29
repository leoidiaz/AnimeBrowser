//
//  AnimeCollectionViewController.swift
//  AnimeBrowser
//
//  Created by Leonardo Diaz on 4/29/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit


class AnimeCollectionViewController: UICollectionViewController {
    //MARK: - Properties
    private let reuseIdentifier = "animeCell"
    
    
    var upcomingAnimes = [Anime]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchAnimes(){
        AnimeController.fetchUpcomingAnimes {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let animes):
                    self.upcomingAnimes = animes
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    
    //MARK: - LifeCylce
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnimes()
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingAnimes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AnimeCollectionViewCell else {return UICollectionViewCell()}
        let anime = upcomingAnimes[indexPath.row]
        //        cell.animeImageView = nil
                AnimeController.fetchImage(anime: anime) { (result) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let animeImage):
                            cell.animeImageView.image = animeImage
                        case .failure(let error):
                            self.presentErrorToUser(localizedError: error)
                        }
                    }
                }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
