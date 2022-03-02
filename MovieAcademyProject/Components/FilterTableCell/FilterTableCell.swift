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

    var isEnabled = false {
        didSet {
            if(isEnabled) {
                buttonImage.image = UIImage(systemName: "circle.dashed.inset.filled")
            } else {
                buttonImage.image = UIImage(systemName: "circle.dashed")
            }
        }
    }

    func loadCell(filterName: String, filterNumber: Int) {
        filterLabel.text = "\(filterName)"
        filterNumberLabel.text = "(\(filterNumber))"
    }
}
