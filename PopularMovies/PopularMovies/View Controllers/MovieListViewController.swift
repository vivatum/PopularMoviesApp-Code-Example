//
//  MovieListViewController.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit
import CocoaLumberjackSwift

fileprivate struct SegueName {
    static let movieDetails = "MovieDetailsSegue"
}

public struct TableViewIdentifier {
    static let movieTableViewId = "movieTableView"
}

final class MovieListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: TitleHeaderView!
    
    private var noDataView: NoDataView?
    
    private(set) var dataSource = MovieListDataSource()
    lazy var viewModel = MovieListViewModel(dataSource: dataSource)
    private var tableDelegate: MovieListTableProtocol?
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        tableDelegate = MovieListTableViewDelegate(viewModel: viewModel)
        
        headerView.delegate = self
        setupTableView()
        getMoviewCollections()
    }
    
    // MARK: - Setup View
    
    private func setupTableView() {
        self.noDataView = NoDataView()
        tableView.dataSource = self.dataSource
        tableView.delegate = self.tableDelegate
        tableView.prefetchDataSource = self.tableDelegate
        tableView.backgroundView = self.noDataView
        tableView.backgroundColor = AppColor.mainBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isAccessibilityElement = true
        tableView.accessibilityIdentifier = TableViewIdentifier.movieTableViewId
    }

    // MARK: - Get Movie collection
    
    private func getMoviewCollections() {
        DDLogInfo("Get Movie collections")
        self.noDataView?.message = .loading
        self.viewModel.fetchPopularMovies()
        self.viewModel.fetchPlayingNowMovies()
    }
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueName.movieDetails {
            guard let movie = sender as? MovieDetails else {
                DDLogError("Can't get MovieDetails from sender")
                return
            }
            if let destinationVC = segue.destination as? UINavigationController {
                if let controller = destinationVC.viewControllers[0] as? MoviewDetailsViewController {
                    controller.movieData = movie
                    controller.modalPresentationStyle = .overCurrentContext
                    DDLogInfo("Go to MoviewDetailsViewController")
                }
            }
        }
    }
}

private extension MovieListViewController {
    func visibleIndexPathsToAdd(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

extension MovieListViewController: MovieViewModelDelegate {
    
    func posterListUpdated(_ posterList: [PlayingNow]) {
        DDLogInfo("Updating poster section")
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
        }
    }
    
    func movieListUpdated(with newIndexPathsToReload: [IndexPath]?, _ noDataMessage: NoDataMessage) {
        DDLogInfo("Updating popular section")
        DispatchQueue.main.async {
            self.noDataView?.message = noDataMessage
            guard let indexPathsToReload = newIndexPathsToReload else {
                self.tableView.reloadData()
                return
            }
            if !indexPathsToReload.isEmpty {
                self.tableView.insertRows(at: indexPathsToReload, with: .automatic)
            }
        }
    }
    
    func showMovieDetails(_ movie: MovieDetails?) {
        guard let details = movie else { return }
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: SegueName.movieDetails, sender: details)
        }
    }
    
    func errorHandling(_ error: ActionError?, _ noDataMessage: NoDataMessage) {
        DDLogError("Error: \(String(describing: error?.localizedDescription))")
        DispatchQueue.main.async {
            if let err = error {
                DDLogError("ActionError content: \(err)")
                AlertHelper.showErrorAlert(err.alertContent)
            }
            self.noDataView?.message = noDataMessage
        }
    }
}

extension MovieListViewController: HeaderViewTapDelegate {
    func headerViewTapped() {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}
