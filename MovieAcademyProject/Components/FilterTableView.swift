//
//  FilterTableView.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 24/2/22.
//

import Foundation
import UIKit

class FilterTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var filtersViewController: FiltersViewController!
    var filtersViewModel: FiltersViewModelProtocol!
    var resultCellIdentifier = "kTableCell"

    enum Filters: Int {
        case genders = 0, types, years
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Filters.genders.rawValue:
            return "Genders"
        case Filters.types.rawValue:
            return "Types"
        case Filters.years.rawValue:
            return "Years"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Filters.genders.rawValue:
            return filtersViewModel.aggregations.genres!.count
        case Filters.types.rawValue:
            return filtersViewModel.aggregations.types!.count
        case Filters.years.rawValue:
            return filtersViewModel.aggregations.ranges!.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resultCellIdentifier, for: indexPath) as? FilterTableCell else {
            return UITableViewCell()
        }

        switch indexPath.section {

        case Filters.genders.rawValue:
            let index = filtersViewModel.aggregations.genres!.index(filtersViewModel.aggregations.genres!.startIndex, offsetBy: indexPath.item)
            cell.loadCell(viewModel: filtersViewModel, filterName: filtersViewModel.aggregations.genres![index].key, filterNumber: filtersViewModel.aggregations.genres![index].value)

        case Filters.types.rawValue:
            let index = filtersViewModel.aggregations.types!.index(filtersViewModel.aggregations.types!.startIndex, offsetBy: indexPath.item)
            cell.loadCell(viewModel: filtersViewModel, filterName: filtersViewModel.aggregations.types![index].key, filterNumber: filtersViewModel.aggregations.types![index].value)

        case Filters.years.rawValue:
            let index = filtersViewModel.aggregations.ranges!.index(filtersViewModel.aggregations.ranges!.startIndex, offsetBy: indexPath.item)
            cell.loadCell(viewModel: filtersViewModel, filterName: filtersViewModel.aggregations.ranges![index].key, filterNumber: filtersViewModel.aggregations.ranges![index].value)

        default:
            return cell
        }


        if(filtersViewModel.selectedAggregations.genres.contains(cell.filterLabel.text!) || filtersViewModel.selectedAggregations.types.contains(cell.filterLabel.text!) || filtersViewModel.selectedAggregations.ranges.contains(cell.filterLabel.text!)) {
            cell.isEnabled = true
            cell.buttonImage.image = UIImage(systemName: "circle.dashed.inset.filled")
        } else {
            cell.isEnabled = false
            cell.buttonImage.image = UIImage(systemName: "circle.dashed")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) as? FilterTableCell else { return }

        switch indexPath.section {

        case Filters.genders.rawValue:
            if(!cell.isEnabled) {
                filtersViewModel.selectedAggregations.genres.append(cell.filterLabel.text!)
            } else {
                filtersViewModel.selectedAggregations.genres.removeAll(where: { string in
                    string == cell.filterLabel.text!
                })
            }

        case Filters.types.rawValue:
            if(!cell.isEnabled) {
                filtersViewModel.selectedAggregations.types.append(cell.filterLabel.text!)
            } else {
                filtersViewModel.selectedAggregations.types.removeAll(where: { string in
                    string == cell.filterLabel.text!
                })
            }

        case Filters.years.rawValue:
            if(!cell.isEnabled) {
                filtersViewModel.selectedAggregations.ranges.append(cell.filterLabel.text!.replacingOccurrences(of: "-", with: "/"))
            } else {
                filtersViewModel.selectedAggregations.ranges.removeAll(where: { string in
                    string == cell.filterLabel.text!.replacingOccurrences(of: "-", with: "/")
                })
            }

        default:
            return
        }

        if (!cell.isEnabled) {
            cell.isEnabled = true
            cell.buttonImage.image = UIImage(systemName: "circle.dashed.inset.filled")
        } else {
            cell.isEnabled = false
            cell.buttonImage.image = UIImage(systemName: "circle.dashed")
        }


        filtersViewModel.callFuncGetMoviesAndAggregations(title: filtersViewModel.titleToSearch, genres: filtersViewModel.selectedAggregations.genres, types: filtersViewModel.selectedAggregations.types, years: filtersViewModel.selectedAggregations.ranges)

        filtersViewController.callToViewModelForUIUpdate()

    }
}
