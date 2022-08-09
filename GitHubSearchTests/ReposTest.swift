//
//  ReposTest.swift
//  GitHubSearchTests
//
//  Created by Lukasz Dziwosz on 08/08/2022.
//

import Foundation
import XCTest

@testable import GitHubSearch

class ReposTest: XCTestCase {

    var sut: Repos!

    override func setUpWithError() throws {
        super.setUp()
        let data = try getData(fromJSON: "SearchResponse")
        sut = try JSONDecoder().decode(Repos.self, from: data)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testJsonMapping() {
        XCTAssertEqual(sut.totalCount, 40)
        XCTAssertEqual(sut.items[0].name, "Tetris")
    }
}
