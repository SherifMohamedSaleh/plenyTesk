//
//  plenyTeskApp.swift
//  plenyTesk
//
//  Created by Sherif Abd El-Moniem on 27/09/2023.
//

import SwiftUI

@main
struct plenyTeskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
