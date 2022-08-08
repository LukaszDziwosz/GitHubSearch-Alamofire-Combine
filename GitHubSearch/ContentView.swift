//
//  ContentView.swift
//  GitHubSearch
//
//  Created by Lukasz Dziwosz on 03/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SearchRepoViewDI().searchRepoView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
