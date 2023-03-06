//
//  NearFriendsApp.swift
//  NearFriends
//
//  Created by Nguyễn Sang on 13/07/2022.
//

import SwiftUI

@main
struct NearFriendsApp: App {
    
    @StateObject private var views = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            LocationViews()
                .environmentObject(views)
        }
    }
}
