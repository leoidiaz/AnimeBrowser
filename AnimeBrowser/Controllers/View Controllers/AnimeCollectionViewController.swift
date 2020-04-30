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
    private let segueIdentifier = "toDetailVC"
    
    var upcomingAnimes = [Anime]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - Private Method
    private func fetchAnimes(){
        AnimeController.fetchUpcomingAnimes { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let animes):
                    self?.upcomingAnimes = animes
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    //MARK: - LifeCylce
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnimes()
        collectionView.allowsMultipleSelection = false
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = #colorLiteral(red: 0.228567034, green: 0.2638508379, blue: 0.3438823223, alpha: 1)
        navigationItem.standardAppearance = appearance
        self.title = "Upcoming Anime"
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingAnimes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AnimeCollectionViewCell else {return UICollectionViewCell()}
        let anime = upcomingAnimes[indexPath.row]
        cell.animeImageView.image = nil
        cell.anime = anime
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first, let destinationVC = segue.destination as? DetailViewController else { return }
            let anime = upcomingAnimes[indexPath.row]
            destinationVC.anime = anime
        }
    }
}
