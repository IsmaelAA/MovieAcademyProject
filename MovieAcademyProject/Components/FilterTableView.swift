//
//  FilterTableView.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 24/2/22.
//

import Foundation
import UIKit

class FilterTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
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
            return filtersViewModel.aggregationsArray.genres.count
        case Filters.types.rawValue:
            return filtersViewModel.aggregationsArray.types.count
        case Filters.years.rawValue:
            return filtersViewModel.aggregationsArray.ranges.count
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
            cell.loadCell(filterName: filtersViewModel.aggregationsArray.genres[indexPath.item], filterNumber: filtersViewModel.aggregations.genres?[filtersViewModel.aggregationsArray.genres[indexPath.item]] ?? 0)
        case Filters.types.rawValue:
            cell.loadCell(filterName: filtersViewModel.aggregationsArray.types[indexPath.item], filterNumber: filtersViewModel.aggregations.types?[filtersViewModel.aggregationsArray.types[indexPath.item]] ?? 0)
        case Filters.years.rawValue:
            cell.loadCell(filterName: filtersViewModel.aggregationsArray.ranges[indexPath.item], filterNumber: filtersViewModel.aggregations.ranges?[filtersViewModel.aggregationsArray.ranges[indexPath.item]] ?? 0)
        default:
            return cell
        }

        if(filtersViewModel.selectedAggregations.genres.contains(cell.filterLabel.text!) || filtersViewModel.selectedAggregations.types.contains(cell.filterLabel.text!) || filtersViewModel.selectedAggregations.ranges.contains(cell.filterLabel.text!.replacingOccurrences(of: "-", with: "/"))) {
            cell.isEnabled = true
        } else {
            cell.isEnabled = false
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterTableCell else { return }

        cell.isEnabled = !cell.isEnabled

        switch indexPath.section {
        case Filters.genders.rawValue:
            if(cell.isEnabled) {
                filtersViewModel.selectedAggregations.genres.append(cell.filterLabel.text!)
            } else {
                filtersViewModel.selectedAggregations.genres.removeAll(where: { string in
                    string == cell.filterLabel.text!
                })
            }

        case Filters.types.rawValue:
            if(cell.isEnabled) {
                filtersViewModel.selectedAggregations.types.append(cell.filterLabel.text!)
            } else {
                filtersViewModel.selectedAggregations.types.removeAll(where: { string in
                    string == cell.filterLabel.text!
                })
            }

        case Filters.years.rawValue:
            if(cell.isEnabled) {
                filtersViewModel.selectedAggregations.ranges.append(cell.filterLabel.text!.replacingOccurrences(of: "-", with: "/"))
            } else {
                filtersViewModel.selectedAggregations.ranges.removeAll(where: { string in
                    string == cell.filterLabel.text!.replacingOccurrences(of: "-", with: "/")
                })
            }

        default:
            return
        }

        filtersViewModel.callFuncGetMoviesAndAggregations(title: filtersViewModel.titleToSearch, genres: filtersViewModel.selectedAggregations.genres, types: filtersViewModel.selectedAggregations.types, ranges: filtersViewModel.selectedAggregations.ranges)
        
        var parentViewController: FiltersViewController? {
            // Starts from next (As we know self is not a UIViewController).
            var parentResponder: UIResponder? = self.next
            while parentResponder != nil {
                if let viewController = parentResponder as? FiltersViewController {
                    return viewController
                }
                parentResponder = parentResponder?.next
            }
            return nil
        }
        
        parentViewController?.callToViewModelForUIUpdate()
    }
}
