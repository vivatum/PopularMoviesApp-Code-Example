//
//  MovieListTableViewDelegate.swift
//  PopularMovies
//
//  Created by Vivatum on 08/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

protocol MovieListTableProtocol: UITableViewDelegate, UITableViewDataSourcePrefetching {}

final class MovieListTableViewDelegate: NSObject, MovieListTableProtocol {
    
    private let viewModel: MovieListViewModelProtocol?
    private let loadingSpinner = UIActivityIndicatorView(style: .medium)
    
    init(viewModel: MovieListViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 160
        case 1:
            return 93
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = AppColor.sectionHeader
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = AppColor.sectionHeaderText
            header.textLabel?.font = AppFont.listSubtitle
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard
            let lastPage = self.viewModel?.popularList.page,
            let totalPages = self.viewModel?.popularList.totalPages,
            lastPage < totalPages
        else {
            loadingSpinner.stopAnimating()
            tableView.tableFooterView?.isHidden = true
            return
        }
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            loadingSpinner.startAnimating()
            loadingSpinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = loadingSpinner
            tableView.tableFooterView?.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            self.viewModel?.selectedIndexPath = indexPath
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            self.viewModel?.fetchPopularMovies()
        }
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let resultsCount = self.viewModel?.popularList.results.count else { return false }
        return indexPath.row >= (resultsCount - 1)
    }
}
