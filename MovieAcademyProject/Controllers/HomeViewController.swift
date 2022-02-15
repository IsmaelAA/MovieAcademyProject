//
//  ViewController.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 9/2/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeSearchBar: UISearchBar!
    @IBOutlet weak var movieCollectionView: MovieCollectionView!

    let resultCellIdentifier = "kCollectionCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let result = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollectionView.register(result, forCellWithReuseIdentifier: resultCellIdentifier)
    }


}

