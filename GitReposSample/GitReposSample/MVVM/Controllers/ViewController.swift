//
//  ViewController.swift
//  GitReposSample
//
//  Created by Blue Peak Systems on 9/6/21.
//

import UIKit
import Alamofire
import SDWebImage
import SafariServices
protocol DataProviderDelegate: class {
    func tableView(didSelectRepository repository: Item?)
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}
class DataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    var repositories: [Item]?
    weak var delegate: DataProviderDelegate?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RepoTableViewCell
        let repo = repositories?[indexPath.row]
        cell.repository = repo
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.tableView(didSelectRepository: repositories?[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}

class ViewController: UIViewController {
 
    var tableView: UITableView!
    private var dataProvider: DataProvider!
    private let refreshControl = UIRefreshControl()
    private let repoViewModel = RepoSearchResultViewModel()

    private var repoSearchResult: RepoSearchResult?
    private var repositories = [Item]()
    private var searchController: UISearchController!
    
    private var pageNo = 1
    private var isLoadingList = false

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Git repo search"
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.tableView = tableView
        
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "Cell")
        dataProvider = DataProvider()
        dataProvider.delegate = self
        tableView.delegate = dataProvider
        tableView.dataSource = dataProvider
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(reloadRepositories), for: .valueChanged)
           tableView.addSubview(refreshControl)
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type repo name to search"
        search.searchBar.delegate = self
        navigationItem.searchController = search
        searchController = search
        // Do any additional setup after loading the view.
    }
//
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        makeRequest("Swift")
//    }
//    
    @objc func reloadRepositories(_ query: String? = "Swift") {
        pageNo = 1
        makeRequest(query ?? searchController.searchBar.text)
    }
    private func makeRequest(_ query: String?) {
        view.startActivityIndicator()
        repoViewModel.fetchRepositories(query, pageNo: pageNo) { (repoSearchResult) in
            DispatchQueue.main.async {
                self.repoSearchResult = repoSearchResult
                let previousRepos = self.repositories
                let currentRepos = self.repoSearchResult?.items ?? [Item]()
                self.repositories = previousRepos + currentRepos
                self.dataProvider.repositories = self.repositories
                self.tableView.reloadData()
                self.view.stopActivityIndicator()
                self.refreshControl.endRefreshing()
                self.isLoadingList = false
                self.pageNo += 1
            }
        }
    }
}

extension ViewController: DataProviderDelegate {
    func tableView(didSelectRepository repository: Item?) {
        let repoUrl = repository?.owner?.htmlURL
        guard let urlString = repoUrl, let url = URL.init(string: urlString) else { return }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let safariVC = SFSafariViewController(url: url, configuration: config)
        present(safariVC, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.isLoadingList = true
            self.makeRequest(searchController.searchBar.text)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return }
        guard let validationMessage = RegexValidator.validate(text) else {
            pageNo = 1
            makeRequest(text)
            return
        }
        showAlert(validationMessage)
    }
}


