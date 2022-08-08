//
//  Repo.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 03/08/2022.
//

import Foundation

struct Repo: Codable, Identifiable, Equatable, Hashable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case htmlURL = "html_url"
        case language
       }

    let id = UUID()
    let name: String
    let owner: Owner
    let htmlURL: String
    let language: String?
}
