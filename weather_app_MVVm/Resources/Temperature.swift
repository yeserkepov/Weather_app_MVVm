//
//  Weather.swift
//  weather app
//
//  Created by Даурен on 09.06.2021.
//

import Foundation

class Temperature: Decodable {
    var temp: Float?
    var feels_like: Float?
    var temp_min: Float?
    var temp_max: Float?
}
