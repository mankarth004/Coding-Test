//
//  RepoSearchResultViewModel.swift
//  GitReposSample
//
//  Created by Blue Peak Systems on 9/7/21.
//

import Foundation
import Alamofire

class RepoSearchResultViewModel {
    func fetchRepositories(_ query: String?, pageNo: Int, completionHandler: @escaping(_ result: RepoSearchResult?)->()) {
        let urlString = "https://api.github.com/search/repositories?q=\(query.defaultUnwrapped)&page=\(pageNo)&per_page=\(Constants.perPageResults)".urlEncoded
        AF.request(urlString).responseDecodable(of: RepoSearchResult.self) { response in
            completionHandler(response.value)
        }
    }
}
