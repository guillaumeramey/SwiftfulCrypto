//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 02/02/2022.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationView {
            HomeView()
              .navigationBarHidden(true)
          }
        }
    }
}
