//
//  MovieCollectionCell.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation
import UIKit

class MovieCollectionCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var favButton: FavButton!
    
    override func prepareForReuse() {
        favButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
    }
}
