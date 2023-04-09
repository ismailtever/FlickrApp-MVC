//
//  NetworkManager.swift
//  FlickrApp
//
//  Created by Ismail Tever on 9.04.2023.
//

import Foundation
class NetworkManager {
    
    static let shared = NetworkManager() //her yerden erişilebilecek şekilde singleton bir obje oluşturdum. Diğer ekranlarda fazladan property tutmamak için.
    
    func fetchImages(with url: String?, completion: @escaping (Data) -> Void) {
        if let urlString = url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    debugPrint(error)
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        completion(data)
                    }
                }
            }.resume()
        }
    }
}
