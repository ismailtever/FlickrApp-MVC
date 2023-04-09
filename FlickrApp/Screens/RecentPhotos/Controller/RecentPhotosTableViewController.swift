//
//  ViewController.swift
//  FlickrApp
//
//  Created by Ismail Tever on 6.04.2023.
//

import UIKit

class RecentPhotosTableViewController: UITableViewController, UISearchResultsUpdating {
    
    private var photosResponse: PhotosResponse? {
        didSet { // responsea bir atama olduğunda tableViewı reload et.
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var selectedPhoto: Photo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        fetchRecentPhotos()
    }
    

    private func fetchRecentPhotos() {
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&format=json&nojsoncallback=1&api_key=fa08c6c936c3925b19d9f5c6e7781bb0&extras=description,owner_name,icon_server,url_n,url_z") else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data {
                do {
                    let photosResponse = try JSONDecoder().decode(PhotosResponse.self, from: data)
                        self.photosResponse = photosResponse
                }catch{
                    print(error)
                    
                }
            }
        }.resume()
    }
    
    private func searchPhotos(with text: String) {
        guard let url = URL(string:                                 "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=fa08c6c936c3925b19d9f5c6e7781bb0&text=\(text)&format=json&nojsoncallback=1&extras=description,owner_name,icon_server,url_n,url_z") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data, let photosResponse = try? JSONDecoder().decode(PhotosResponse.self, from: data) {
                self.photosResponse = photosResponse
                
                
            }
        }.resume()
    }
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type Something to Search"
        navigationItem.searchController = search
    }
    
    // MARK: - UITableViewDataSoruce & UI TableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosResponse?.photos?.photo?.count ?? .zero
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = photosResponse?.photos?.photo?[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell
        cell.ownerNameLabel.text = photo?.ownername
        cell.titleLabel.text = photo?.title
        
        NetworkManager.shared.fetchImages(with: photo?.buddyIconURL) { data in
            cell.ownerImageView.image = UIImage(data: data)
        }
        
        NetworkManager.shared.fetchImages(with: photo?.urlN) { data in
            cell.photoImageView.image = UIImage(data: data)
        }
        
        return cell
    }
    
    //İndex Pathe göre bir tıklama yapıldığında
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPhoto = photosResponse?.photos?.photo?[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    
    // MARK: - Navigation
    //      Get the new view controller using segue.destination.
    //      Pass the selected object to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PhotoDetailViewController{
            // TODO: Seçilen fotoğrafı detay ekranına gönder.
            viewController.photo = selectedPhoto
        }
    }
    
    // MARK: - UISearchResultUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        if text.count > 2 {
            print(text)
            searchPhotos(with: text)
        }
    }
    
    
}


