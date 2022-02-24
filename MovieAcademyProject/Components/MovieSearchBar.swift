//
//  MovieSearchBar.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 17/2/22.
//

import Foundation
import UIKit

class MovieSearchBar: UISearchBar, UISearchBarDelegate {

    var viewController: HomeViewController!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(!searchText.isEmpty) {
            viewController.homeViewModel.callFuncGetMoviesByTitle(title: searchText)
        } else {
            viewController.homeViewModel.callFuncGetMoviesByTitle(title: "a")
        }
        viewController.callToViewModelForUIUpdate()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewController.homeViewModel.callFuncGetMoviesByTitle(title: "a")
        viewController.callToViewModelForUIUpdate()
    }
}
