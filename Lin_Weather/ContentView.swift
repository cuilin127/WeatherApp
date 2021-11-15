//
//  ContentView.swift
//  Lin_Weather
//
//  Created by Lin Cui on 2021-11-09.
//  Student number: 991456394
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    
    @EnvironmentObject var fetcher : WeatherFetcher
    @State private var urlString = " "
    var body: some View {
        VStack{
            Text("Lin_Weather")
            List{
                Text("City: \(fetcher.weather.location.name)")
                    .padding()
                Text("Country: \(fetcher.weather.location.country)")
                    .padding()
                Text("Condition: \(fetcher.weather.current.condition.text)").padding()
                Text("Temperature: \(String(format: "%.1f", fetcher.weather.current.temp_c))°C").padding()
                Text("Feels like: \(String(format: "%.1f", fetcher.weather.current.feelslike_c))°C").padding()
                Text("Wind Speed: \(String(format: "%.1f", fetcher.weather.current.wind_kph))km/h").padding()
                Text("Wind Direction: \(fetcher.weather.current.wind_dir)").padding()
                Text("Humidity: \(fetcher.weather.current.humidity)%").padding()
                Text("Ultra Violet: \(String(format: "%.1f", fetcher.weather.current.uv))").padding()
                Text("Visibility: \(String(format: "%.1f", fetcher.weather.current.vis_km))km").padding()
            }
            
        }.onAppear {
            fetcher.apiURL="https://api.weatherapi.com/v1/current.json?key=7a9f8e3715934c66be021643211011&q=\(self.locationHelper.currentLocation!.coordinate.latitude),\(self.locationHelper.currentLocation!.coordinate.longitude)&aqi=no"
            fetcher.fetchDataFromAPI()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
