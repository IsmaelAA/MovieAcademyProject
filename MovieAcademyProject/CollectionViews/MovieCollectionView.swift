//
//  MovieCollectionView.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 10/2/22.
//

import Foundation
import UIKit

class MovieCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var moviesData: [MovieWithURL]!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
        self.moviesData = [MovieWithURL]()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "kCollectionCell", for: indexPath) as! MovieCollectionCell

        cell.movieInCell = moviesData[indexPath.item]
        cell.loadMovie()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("me has pulsado")
    }



}

