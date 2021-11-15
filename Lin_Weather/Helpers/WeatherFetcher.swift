//
//  WeatherFetcher.swift
//  Lin_Weather
//
//  Created by Lin Cui on 2021-11-14.
//

import Foundation

class WeatherFetcher:ObservableObject{
    @Published var apiURL = ""
    @Published var weather = Weather()
    
    init(){
        fetchDataFromAPI()
    }
    func fetchDataFromAPI(){
//        urlString="https://api.weatherapi.com/v1/current.json?key=7a9f8e3715934c66be021643211011&q=\(self.locationHelper.currentLocation!.coordinate.latitude),\(self.locationHelper.currentLocation!.coordinate.longitude)&aqi=no"
        //var apiURL = urlString
        
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
