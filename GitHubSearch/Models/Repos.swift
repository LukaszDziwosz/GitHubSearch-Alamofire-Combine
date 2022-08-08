//
//  Repos.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 04/08/2022.
//

import Foundation

struct Repos: Codable {
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }

    let totalCount: Int?
    let items: [Repo]

}
