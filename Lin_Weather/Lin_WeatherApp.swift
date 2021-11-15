//
//  Lin_WeatherApp.swift
//  Lin_Weather
//
//  Created by Lin Cui on 2021-11-09.
//

import SwiftUI
import CoreLocation
@main
struct Lin_WeatherApp: App {
    
    let locationHelper = LocationHelper()
    //var fetcher = WeatherFetcher()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(locationHelper)
        }
    }
}
