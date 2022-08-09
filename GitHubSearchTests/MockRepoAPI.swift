//
//  MockRepoAPI.swift
//  GitHubSearchTests
//
//  Created by Lukasz Dziwosz on 08/08/2022.
//

import Foundation
import Combine
import Alamofire

@testable import GitHubSearch

class MockRepoAPI: RepoAPIProtocol {

    var mockRepos: Repos {
        let data = Repos(totalCount: 1, items: [Repo(name: "Tetris", owner: Owner(avatarURL: "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"), htmlURL: "https://github.com/dtrupenn/Tetris", language: "Assembly")])
        return data
    }

    // confirming to protocol returning mock responsse
    func getRepos<T>(quary: String, perPage: Int, page: Int) -> AnyPublisher<T, AFError> {
        if T.self == Repos.self {
            return Just(mockRepos as! T)
                .setFailureType(to: AFError.self)
                .eraseToAnyPublisher()
        }

        return Fail(error: NSError() as! AFError).eraseToAnyPublisher()
    }
}
