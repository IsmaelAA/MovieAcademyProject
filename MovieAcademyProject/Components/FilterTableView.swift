//
//  FilterTableView.swift
//  MovieAcademyProject
//
//  Created by Ismael Alba Areces on 24/2/22.
//

import Foundation
import UIKit

class FilterTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var homeViewModel: HomeViewModel!
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
            return homeViewModel.aggregations.genres!.count
        case Filters.types.rawValue:
            return homeViewModel.aggregations.types!.count
        case Filters.years.rawValue:
            return homeViewModel.aggregations.ranges!.count
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
            let index = homeViewModel.aggregations.genres!.index(homeViewModel.aggregations.genres!.startIndex, offsetBy: indexPath.item)
            cell.loadCell(viewModel: homeViewModel, filterName: homeViewModel.aggregations.genres![index].key, filterNumber: homeViewModel.aggregations.genres![index].value)
        case Filters.types.rawValue:
            let index = homeViewModel.aggregations.types!.index(homeViewModel.aggregations.types!.startIndex, offsetBy: indexPath.item)
            cell.loadCell(viewModel: homeViewModel, filterName: homeViewModel.aggregations.types![index].key, filterNumber: homeViewModel.aggregations.types![index].value)
        case Filters.years.rawValue:
            let index = homeViewModel.aggregations.ranges!.index(homeViewModel.aggregations.ranges!.startIndex, offsetBy: indexPath.item)
            cell.loadCell(viewModel: homeViewModel, filterName: homeViewModel.aggregations.ranges![index].key, filterNumber: homeViewModel.aggregations.ranges![index].value)
        default:
            return cell
        }

        return cell
    }
}
