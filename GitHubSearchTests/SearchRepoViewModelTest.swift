//
//  SearchRepoViewModelTest.swift
//  GitHubSearchTests
//
//  Created by Lukasz Dziwosz on 08/08/2022.
//

import XCTest
import Combine

@testable import GitHubSearch

class SearchRepoViewModelTest: XCTestCase {

    private var networking: MockRepoAPI!
    private var viewModel: SearchRepoViewModel!

    override func setUp() {
        super.setUp()
        networking = MockRepoAPI()
        viewModel = SearchRepoViewModel(networking: networking)
    }

    func test_fetchRepos() {
        let sut = viewModel
        sut!.fetchRepos()
        XCTAssertTrue(sut!.listFull)
    }
}

