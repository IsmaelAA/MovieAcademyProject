//
//  FilterTableCell.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 24/2/22.
//

import Foundation
import UIKit

class FilterTableCell: UITableViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterNumberLabel: UILabel!
    @IBOutlet weak var buttonImage: UIImageView!

    var viewModel: FiltersViewModelProtocol!
    var isEnabled = false
    
    func loadCell(viewModel: FiltersViewModelProtocol, filterName: String, filterNumber: Int) {
        self.viewModel = viewModel
        filterLabel.text = "\(filterName)"
        filterNumberLabel.text = "(\(filterNumber))"
    }
}
