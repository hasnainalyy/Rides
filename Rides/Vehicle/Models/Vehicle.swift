//
//  Vehicle.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-09.
//

import Foundation

struct Vehicle: Codable {
    let id: Int
    let vin: String
    let carType: String
    let makeAndModel, color: String?
    let kilometrage: Int
   
    
    enum CodingKeys: String, CodingKey {
        case id, vin
        case makeAndModel = "make_and_model"
        case color
        case carType = "car_type"
        case kilometrage
       
    }
}

//MARK: - Enum for Sort options
enum SortOption: String {
    case vin = "VIN"
    case carType = "Car Type"
}
