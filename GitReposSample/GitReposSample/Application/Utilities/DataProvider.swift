//
//  DataProvider.swift
//  GitReposSample
//
//  Created by Blue Peak Systems on 9/8/21.
//

import Foundation
import UIKit

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
