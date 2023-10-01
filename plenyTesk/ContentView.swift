//
//  ContentView.swift
//  plenyTesk
//
//  Created by Sherif Abd El-Moniem on 27/09/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @StateObject private var coordinator = Coordinator()


    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page:  .login)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
