//
//  Weather.swift
//  Lin_Weather
//
//  Created by Lin Cui on 2021-11-09.
//

import Foundation
struct Weather: Codable{
    var location:Location
    var current: Current
    init(){
        location = Location.init()
        current = Current.init()
    }
}
struct Location:Codable{
    var name: String
    var country: String
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case country = "country"
    }
    init(){
        name = ""
        country = ""
    }
    init(from decoder: Decoder) throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try response.decodeIfPresent(String.self, forKey: .name) ?? "Unavailable"
        self.country = try response.decodeIfPresent(String.self, forKey: .country) ?? "Unavailable"
    }
}
struct Current: Codable{
    
    var temp_c: Double
    var feelslike_c: Double
    var wind_kph: Double
    var wind_dir: String
    var humidity: Int
    var uv: Double
    var vis_km: Double
    var condition: Condition
    
    enum CodingKeys: String, CodingKey{
        case temp_c = "temp_c"
        case feelslike_c = "feelslike_c"
        case wind_kph = "wind_kph"
        case wind_dir = "wind_dir"
        case humidity = "humidity"
        case uv = "uv"
        case vis_km = "vis_km"
        case condition = "condition"
    }
    init(){

        temp_c = 0.0
        feelslike_c = 0.0
        wind_kph = 0.0
        wind_dir = ""
        humidity = 0
        uv = 0.0
        vis_km = 0.0
        condition = Condition.init()
    }
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.temp_c = try response.decodeIfPresent(Double.self, forKey: .temp_c) ?? 0.0
        self.feelslike_c = try response.decodeIfPresent(Double.self, forKey: .feelslike_c) ?? 0.0
        self.wind_kph = try response.decodeIfPresent(Double.self, forKey: .wind_kph) ?? -0.0
        self.wind_dir = try response.decodeIfPresent(String.self, forKey: .wind_dir) ?? "unKnown"
        self.humidity = try response.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
        self.uv = try response.decodeIfPresent(Double.self, forKey: .uv) ?? 0.0
        self.vis_km = try response.decodeIfPresent(Double.self, forKey: .vis_km) ?? 0.0
        self.condition = try response.decodeIfPresent(Condition.self, forKey: .condition) ?? Condition.init()
    }
    
}
struct Condition:Codable{
    var text:String
    enum CodingKeys: String, CodingKey{
        case text = "text"
    }
    init(){
        text = ""
    }
    init(from decoder:Decoder)throws{
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try response.decodeIfPresent(String.self, forKey: .text) ?? "unknown"
    }
}
