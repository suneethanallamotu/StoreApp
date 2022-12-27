//
//  StoreAppApp.swift
//  StoreApp
//
//  Created by Suneetha Nallamotu on 12/23/22.
//

import SwiftUI

@main
struct StoreAppApp: App {
    @StateObject private var storeModel = StoreModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
