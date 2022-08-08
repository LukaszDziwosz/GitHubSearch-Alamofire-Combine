//
//  SearchRepoViewModel.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 04/08/2022.
//

import Foundation
import Combine

final class SearchRepoViewModel: ObservableObject {

    // MARK: - Published properties

    @Published var searchQuery = ""
    @Published private(set) var state = PageState.idle


    // MARK: - Properties

    enum PageState {
        case idle
        case loading
        case failed(ErrorType)
        case loaded([Repo])
    }

    private var subscriptions: Set<AnyCancellable> = []
    private let networking: RepoAPIProtocol
    private let debounceInterval: DispatchQueue.SchedulerTimeType.Stride = .seconds(1)

    var listFull = false
    var currentPage = 1
    private let perPage = 10

    // MARK: - Initializers

    init(networking: RepoAPIProtocol) {
        self.networking = networking
    }

    // MARK: - Methods

   func listenToSearch(){
        $searchQuery
            .removeDuplicates()
            .debounce(for: debounceInterval, scheduler: DispatchQueue.main)
            .sink { [weak self] delayQuary in
                guard let self = self else { return }
                self.currentPage = 1
                if !delayQuary.isEmpty {
                    self.fetchRepos()
                } else {
                    self.state = .idle
                }
            }
            .store(in: &subscriptions)
    }

    func fetchRepos() {
        self.state = .loading
        networking.getRepos(quary: searchQuery, perPage: perPage, page: currentPage)
            .sink {[weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    if let code = error.responseCode {
                        self.state = .failed(.backend(code))
                    }
                    if error.isSessionTaskError {
                        self.state = .failed(.noInternet)
                    }
                    if error.isResponseSerializationError {
                        self.state = .failed(.decoding)
                    }
                case .finished:
                    break
                }
            } receiveValue: {[weak self] value in
                guard let self = self else { return }
                self.state = .loaded(value.items)
                if value.items.count < self.perPage {
                    self.listFull = true
                } else {
                    self.listFull = false
                }
            }
            .store(in: &subscriptions)
    }
}
