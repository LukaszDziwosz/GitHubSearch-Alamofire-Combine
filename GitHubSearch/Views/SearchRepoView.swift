//
//  SearchRepoView.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 04/08/2022.
//

import SwiftUI

struct SearchRepoView: View {
    
    @ObservedObject var viewModel: SearchRepoViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .idle:
                    IdleView()
                        .onAppear {
                            viewModel.listenToSearch()
                        }
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error)
                case .loaded(let repos):
                    List {
                        // go back button
                        if viewModel.currentPage > 1 {
                            Button {
                                viewModel.currentPage -= 1
                                viewModel.fetchRepos()
                            } label: {
                                Text("Go back")
                            }
                        }
                        // main list
                        ForEach(repos) { repo in
                            NavigationLink(destination: WebView(url: URL(string: repo.htmlURL)!)) {
                                RepoListRow(repo: repo)
                            }
                            .isDetailLink(false)
                        }
                        // load more button
                        if !viewModel.listFull {
                            HStack {
                                Button {
                                    viewModel.currentPage += 1
                                    viewModel.fetchRepos()
                                } label: {
                                    Text("Load more")
                                }
                                
                            }
                        }

                    } // List
                } // switch State

            } // Main Vstack
            .navigationTitle("Repos Search")

        } // NavigationView
        .searchable(text: $viewModel.searchQuery)
        .onSubmit(of: .search, viewModel.fetchRepos)
    }
}

struct SearchRepoView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRepoViewDI().searchRepoView
    }
}
