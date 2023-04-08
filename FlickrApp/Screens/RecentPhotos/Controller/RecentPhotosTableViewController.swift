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
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        fetchRecentPhotos()
    }
    
    
    private func fetchRecentPhotos() {
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=fa08c6c936c3925b19d9f5c6e7781bb0&format=json&nojsoncallback=1&extras=description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,geo,tags,machine_tags,o_dims,views,media,path_alias,url_sq,url_t,url_s,url_q,url_m,url_n,url_z,url_c,url_l,url_o") else {return}
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
    private func searchPhotos(with text: String) {
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=fa08c6c936c3925b19d9f5c6e7781bb0&text=flower&format=json&nojsoncallback=1&extras=description,license,date_upload,date_taken,owner_name,icon_server,original_format,last_update,geo,tags,machine_tags,o_dims,views,media,path_alias,url_sq,url_t,url_s,url_q,url_m,url_n,url_z,url_c,url_l,url_o") else {return}
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
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell
        cell.ownerImageView.backgroundColor = .darkGray
        cell.ownerNameLabel.text = "Owner Name"
        cell.photoImageView.backgroundColor = .gray
        cell.titleLabel.text = "Title Label"
        return cell
    }
    
    //İndex Pathe göre bir tıklama yapıldığında
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    
    // MARK: - Navigation
    //      Get the new view controller using segue.destination.
    //      Pass the selected object to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PhotoDetailViewController{
            // TODO: Seçilen fotoğrafı detay ekranına gönder.
            
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


