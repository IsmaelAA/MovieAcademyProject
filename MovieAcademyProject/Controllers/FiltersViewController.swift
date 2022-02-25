//
//  FiltersViewController.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 24/2/22.
//

import Foundation
import UIKit

class FiltersViewController: UIViewController {

    var filtersViewModel: FiltersViewModelProtocol!

    @IBOutlet weak var filtersTable: FilterTableView!

    let resultCellIdentifier = "kTableCell"

    override func viewDidLoad() {
        filtersTable.filtersViewController = self
        filtersTable.filtersViewModel = self.filtersViewModel
        let result = UINib(nibName: "FilterTableViewCell", bundle: nil)
        filtersTable.register(result, forCellReuseIdentifier: resultCellIdentifier)
        callToViewModelForUIUpdate()
    }

    func callToViewModelForUIUpdate() {
        self.filtersViewModel.bindFiltersViewModelToController = {
            DispatchQueue.main.async {
                self.filtersTable.filtersViewModel = self.filtersViewModel
                self.filtersTable.reloadData()
            }
        }
    }
}
