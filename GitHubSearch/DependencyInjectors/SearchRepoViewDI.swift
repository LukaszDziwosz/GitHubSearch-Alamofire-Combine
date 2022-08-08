//
//  SearchRepoViewDI.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 08/08/2022.
//

import Foundation

struct SearchRepoViewDI {

    var searchRepoView: SearchRepoView {
        SearchRepoView(viewModel: searchRepoViewModel)
    }
    private var searchRepoViewModel: SearchRepoViewModel {
        SearchRepoViewModel(networking: networking)
    }
    private var networking: RepoAPIProtocol {
        RepoAPI()
    }
}
