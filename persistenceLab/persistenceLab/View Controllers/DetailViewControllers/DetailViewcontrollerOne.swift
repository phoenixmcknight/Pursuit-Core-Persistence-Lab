//
//  DetailViewcontrollerOne.swift
//  persistenceLab
//
//  Created by Phoenix McKnight on 9/30/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
import UIKit

class DetailViewControllerOne:UIViewController {
  
    var passingInfo: Hit!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var previewURLLabel: UILabel!
    
    @IBOutlet weak var webFormatLabel: UILabel!
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
     likesLabel.text =  passingInfo.likes == nil ? "That information is not available" : passingInfo.likes?.description
        
        favoritesLabel.text =  passingInfo.favorites == nil ? "That information is not available" : passingInfo.favorites?.description
        tagsLabel.text =  passingInfo.tags == nil ? "That information is not available" : passingInfo.tags
        previewURLLabel.text =  passingInfo.previewURL == nil ? "That information is not available" : passingInfo.previewURL
        webFormatLabel.text =  passingInfo.webformatURL == nil ? "That information is not available" : passingInfo.webformatURL
        
        if let image = passingInfo.largeImageURL {
        ImageHelper.shared.getImage(urlStr: image) {
            (results) in
            DispatchQueue.main.async {
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let picture):
                    self.imageViewOutlet.image = picture
                }
            }
            }
        }
}
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        let newPicture = FavoriteImages(tags: passingInfo?.tags, favorites: passingInfo?.favorites, likes: passingInfo?.likes, imageURL: passingInfo?.largeImageURL)
        
        DispatchQueue.global(qos: .utility).async {
            try?
            
            ImagePersistenceHelper.manager.save(newImage: newPicture)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }

    }
}
