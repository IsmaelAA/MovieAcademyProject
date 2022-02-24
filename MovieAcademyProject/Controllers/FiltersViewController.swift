//
//  FiltersViewController.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 24/2/22.
//

import Foundation
import UIKit

class FiltersViewController: UIViewController {

    var homeViewModel: HomeViewModel!
    @IBOutlet weak var filtersTable: FilterTableView!

    let resultCellIdentifier = "kTableCell"

    override func viewDidLoad() {
        filtersTable.homeViewModel = homeViewModel

        let result = UINib(nibName: "FilterTableViewCell", bundle: nil)
        filtersTable.register(result, forCellReuseIdentifier: resultCellIdentifier)

    }
}
