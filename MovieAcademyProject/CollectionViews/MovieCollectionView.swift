//
//  MovieCollectionView.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation
import UIKit

class MovieCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return MovieCollectionCell()
    }
    

}
