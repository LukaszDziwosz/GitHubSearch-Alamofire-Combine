//
//  Owner.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 03/08/2022.
//

import Foundation

struct Owner: Codable, Equatable, Hashable {

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }

    let avatarURL: String?
}
