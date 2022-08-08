//
//  RepoListRow.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 08/08/2022.
//

import SwiftUI

struct RepoListRow: View {

    let repo: Repo

    var body: some View {
        VStack(alignment: .leading) {
            Text(repo.name)
                .font(.headline)
            (
                Text(repo.language ?? ""))
        }
    }
}

//struct RepoListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RepoListRow()
//    }
//}
