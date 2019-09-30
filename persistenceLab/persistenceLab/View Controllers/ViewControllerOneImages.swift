//
//  ViewControllerOneImages.swift
//  persistenceLab
//
//  Created by Phoenix McKnight on 9/30/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerOne:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate {
   
    var pictures = [Hit]() {
        didSet {
            collectionViewOutlet.reloadData()
        }
    }
    
    var searchString:String? = nil {
        didSet {
            
            collectionViewOutlet.reloadData()
        }
    }
    
    var searchResults: [Hit] {
        guard let searchString = searchString else {
            return pictures
        }
        guard searchString != "" else {
            return pictures
        }
        return pictures
    }
    
   
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
    }
    func loadData(searchTerm:String) {
        PictureAPIClient.shared.getPictures(searchTerm: searchTerm) {
            (results) in
            DispatchQueue.main.async {
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.pictures = data
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pictureIndexPath = pictures[indexPath.item]
        let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "picture", for: indexPath) as! CollectionViewCell
        
        if let unwrappedPicture = pictureIndexPath.largeImageURL {
        ImageHelper.shared.getImage(urlStr: unwrappedPicture) {
            (results) in
            DispatchQueue.main.async {
                switch results {
                case .failure(let error):
                    print(error)
                    cell.pictureImage.image = UIImage(named: "imageLoadError")
                case .success(let validPicture):
                    cell.activityIndicator.stopAnimating()
                    
                    cell.pictureImage.image = validPicture
                    
                }
            }
        }
        } else {
                              cell.pictureImage.image = UIImage(named: "imageLoadError")
            cell.activityIndicator.stopAnimating()
            
        }
      return cell
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchString = searchBar.text
        loadData(searchTerm: searchBar.text!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailStoryBoard = storyboard?.instantiateViewController(withIdentifier: "DetailViewControllerOne") as! DetailViewControllerOne
        
detailStoryBoard.passingInfo = pictures[indexPath.item]
        
        
        navigationController?.pushViewController(detailStoryBoard, animated: true)
    }
    func setUP() {
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        searchBarOutlet.delegate = self
    }
    
    
}
