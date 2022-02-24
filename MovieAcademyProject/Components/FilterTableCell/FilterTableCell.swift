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
    @IBOutlet weak var filterSwitch: UISwitch!

    var viewModel: HomeViewModelProtocol!

    func loadCell(viewModel: HomeViewModel, filterName: String, filterNumber: Int) {
        self.viewModel = viewModel
        filterLabel.text = "\(filterName) \(filterNumber)"
    }

    @IBAction func enableFilter(_ sender: Any) {

    }
}
