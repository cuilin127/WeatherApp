//
//  ContentView.swift
//  Lin_Weather
//
//  Created by Lin Cui on 2021-11-09.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var locationHelper : LocationHelper
    
    @State private var weather:Weather = Weather.init()
    @State private var urlString = " "
    var body: some View {
        VStack{
            Text("Lin_Weather")
            List{
                Text("City: \(weather.location.name)")
                    .padding()
                Text("Country: \(weather.location.country)")
                    .padding()
                Text("Condition: \(weather.current.condition.text)").padding()
                Text("Temperature: \(String(format: "%.1f", weather.current.temp_c))°C").padding()
                Text("Feels like: \(String(format: "%.1f", weather.current.feelslike_c))°C").padding()
                Text("Wind Speed: \(String(format: "%.1f", weather.current.wind_kph))km/h").padding()
                Text("Wind Direction: \(weather.current.wind_dir)").padding()
                Text("Humidity: \(weather.current.humidity)%").padding()
                Text("Ultra Violet: \(String(format: "%.1f", weather.current.uv))").padding()
                Text("Visibility: \(String(format: "%.1f", weather.current.vis_km))km").padding()
                
            }
//            Text("\(weather.location.name),\(weather.location.country) ")
//            Text("\(weather.current.wind_dir),\(weather.current.temp_c),\(weather.current.condition.text) ")
//                .padding()

            
        }.onAppear {
            fetchDataFromAPI()
        }
    }
    func fetchDataFromAPI(){
        urlString="https://api.weatherapi.com/v1/current.json?key=7a9f8e3715934c66be021643211011&q=\(self.locationHelper.currentLocation!.coordinate.latitude),\(self.locationHelper.currentLocation!.coordinate.longitude)&aqi=no"
        var apiURL = urlString
        
        
        var weather = Weather.init()
        guard let api = URL(string: apiURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: api){(data: Data?, response: URLResponse?, error: Error?) in
            
            if let err = error{
                print(#function, err)
            }else{
                //received data or response
                print("got data")
                DispatchQueue.global().async {
                    do{
                        
                        if let jsonData = data{
                            let decoder = JSONDecoder()

                            //use this if API response is an array of JSON objects
                            let decodedWeather = try decoder.decode(Weather.self, from: jsonData)

                            DispatchQueue.main.async {
                                self.weather = decodedWeather
                            }
                        }else{
                            print(#function, "No JSON data received")
                        }
                    }catch let error{
                        print(#function, error)
                    }
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
