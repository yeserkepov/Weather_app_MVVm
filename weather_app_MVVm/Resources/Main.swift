//
//  Main.swift
//  weather app
//
//  Created by Даурен on 09.06.2021.
//

import Foundation

class Main: Decodable {
    let weather: [Weather]
    let main: Temperature
    let dt: Int
    let name: String
}
