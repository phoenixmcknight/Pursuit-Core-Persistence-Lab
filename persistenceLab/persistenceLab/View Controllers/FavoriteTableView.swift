//
//  FavoriteTableView.swift
//  persistenceLab
//
//  Created by Phoenix McKnight on 9/30/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class FavoriteTableView:UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteImages = [FavoriteImages]() {
        didSet {
            favoriteTableView.reloadData()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setUp()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favorites = favoriteImages[indexPath.row]
       
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "cell") as! FavoriteTableViewCell
        
       
         cell.favoriteLikeLabel.text = favorites.likes == nil ? "Likes Data is not available" : "Likes : \(String(describing: favorites.likes!))"
        
        
        if let image = favorites.imageURL {
            ImageHelper.shared.getImage(urlStr: image) {
                (results) in
                DispatchQueue.main.async {
                    switch results {
                    case .failure(let error):
                        print(error)
                    case .success(let picture):
                        cell.favoriteImage.image = picture
                    }
                }
            }
        } else {
            cell.favoriteImage.image = UIImage(named: "imageLoadError")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var detailFavorites = storyboard?.instantiateViewController(withIdentifier: "DetailFavoriteViewController") as! DetailFavoriteViewController
        
detailFavorites.passingInfo = favoriteImages[indexPath.row]
        
        navigationController?.pushViewController(detailFavorites, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    func loadData() {
        do { favoriteImages = try ImagePersistenceHelper.manager.getSloths()
            
        } catch let error {
        print(error)
        }
    }
 
    
 
    func setUp() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
}
