//
//  DetailFavoritesFromTableView.swift
//  persistenceLab
//
//  Created by Phoenix McKnight on 9/30/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class DetailFavoriteViewController:UIViewController {
   
    var passingInfo: FavoriteImages!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var detailImageOutlet: UIImageView!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
    }
    func setUP() {
        favoriteLabel.text = passingInfo.favorites == nil ? "Favorite Data is not available" : "Favorites : \(String(describing: passingInfo.favorites!)))"
        
        tagLabel.text = passingInfo.tags == nil ? "Tag Data is not available" : "Tags: \(String(describing: passingInfo.tags!)))"
        
        likeLabel.text = passingInfo.likes == nil ? "Tag Data is not available" : "Tags: \(String(describing: passingInfo.likes!)))"
        
        if let image = passingInfo.imageURL {
            ImageHelper.shared.getImage(urlStr: image) {
                (results) in
                DispatchQueue.main.async {
                    switch results {
                    case .failure(let error):
                        print(error)
                    case .success(let image):
                        self.imageOutlet.image = image
                    }
                }
            }
        } else {
            imageOutlet.image = UIImage(named: "imageLoadError")
        }
        
    }
}

