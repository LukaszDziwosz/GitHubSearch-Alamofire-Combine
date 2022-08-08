//
//  RepoAPI.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 04/08/2022.
//

import Foundation
import Combine
import Alamofire

protocol RepoAPIProtocol {
    func getRepos(quary: String, perPage: Int, page: Int) -> AnyPublisher<Repos, AFError>
}

struct RepoAPI: RepoAPIProtocol {
    func getRepos(quary: String, perPage: Int, page: Int) -> AnyPublisher<Repos, AFError> {

        let url = URL(string: "https://api.github.com/search/repositories")!

        let parameters = [
            "q": quary,
            "per_page": perPage,
            "page": page,
        ] as [String : Any]

        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]

        return AF.request(url,
                          method: .get,
                          parameters: parameters,
                          headers: headers
                          )
            .validate()
            .publishDecodable(type: Repos.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
