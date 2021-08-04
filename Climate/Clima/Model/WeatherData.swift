//
//  WeatherData.swift
//  Clima
//
//  Created by Mihir Solanki on 29/07/21.



import Foundation

struct weatherdata:Codable {
    let name: String
    let main:Main
    let weather: [Weather]
    
}

struct Main:Codable {
    let temp: Double
}

struct Weather:Codable {
    let id: Int
}
