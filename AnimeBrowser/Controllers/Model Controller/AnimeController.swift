//
//  AnimeController.swift
//  AnimeBrowser
//
//  Created by Leonardo Diaz on 4/29/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation
import UIKit.UIImage

class AnimeController {
    
    static private let baseURL = URL(string: "https://api.jikan.moe/v3")
    
    static func fetchUpcomingAnimes(completion: @escaping (Result<[Anime], AnimeError>) -> Void){
        // URL -- https://api.jikan.moe/v3/top/anime/1/upcoming
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        let reference = baseURL.appendingPathComponent("top")
        let type = reference.appendingPathComponent("anime")
        let page = type.appendingPathComponent("1")
        let subtype = page.appendingPathComponent("upcoming")
        let finalURL = subtype
        print(finalURL)
        // Session
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // Error
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            // Data
            guard let data = data else { return completion(.failure(.noData))}
            
            // Decode
            do {
                let topLevelObject = try JSONDecoder().decode(AnimeTopLevelObject.self, from: data)
                let animeArray = topLevelObject.top
                return completion(.success(animeArray))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(anime: Anime, completion: @escaping (Result<UIImage, AnimeError>)-> Void) {
        guard let imageURL = URL(string: anime.imageURL) else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let animePoster = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            return completion(.success(animePoster))
        }.resume()
    }
}
