//
//  AnimeViewController.swift
//  AnimeBrowser
//
//  Created by Leonardo Diaz on 4/30/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class AnimeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
    var searchAnimes = [Anime]() {
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
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnimes()
        collectionView.allowsMultipleSelection = false
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first, let searchBar = searchBar.text, let destinationVC = segue.destination as? DetailViewController else { return }
            
            if searchBar.isEmpty {
                let anime = upcomingAnimes[indexPath.row]
                destinationVC.anime = anime
            } else {
                let anime = searchAnimes[indexPath.row]
                destinationVC.anime = anime
            }
        }
    }
}


    //MARK: - UICollectionView DataSource
extension AnimeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let searchBar = searchBar.text else { return  1}
        return searchBar.isEmpty ? upcomingAnimes.count : searchAnimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AnimeCollectionViewCell, let searchBar = searchBar.text else {return UICollectionViewCell()}
        
        if searchBar.isEmpty {
            let anime = upcomingAnimes[indexPath.row]
            cell.anime = anime
        } else {
            let searchAnime = searchAnimes[indexPath.row]
            cell.search = searchAnime
        }
        
        return cell
    }
}

    //MARK: - UISearchBar Delegate
extension AnimeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        AnimeController.fetchSearch(searchTerm: searchTerm) { [weak self ](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let animes):
                    self?.searchAnimes = animes
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            fetchAnimes()
        }
    }
}
