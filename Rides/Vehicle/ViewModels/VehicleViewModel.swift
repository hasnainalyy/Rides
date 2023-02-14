//
//  VehicleViewModel.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-09.

import Foundation
import SwiftUI

class VehicleViewModel: ObservableObject {
 
    var networkManager: NetworkManager
    //MARK: - Init
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    @Published var allVehicles: [Vehicle] = []
    @Published var numberVehicle: String = ""
    @Published var sortOption: SortOption = .vin
    
    //for alert
    @Published var showAlert = false
    @Published var alertTitle = ""
    
    //API loading state
    @Published var isLoading = false
    
       
    //MARK: - API - Get Vehicles
    /// - Main actor is used to update UI on main thread
    @MainActor
    func getVehicles(size: Int) async{
        
        let isValidate = validate(input: Int(numberVehicle))
        if isValidate == false {
            self.alertTitle = Constant.invalidInputMessage
            self.showAlert = true
            return
        }
        isLoading = true
        
        //Construct url
        let url = String(format: Constant.vehiclesUrl, size)
            do{
                let result: [Vehicle] = try await networkManager.fetch(from: url)
                
                if sortOption.rawValue == "VIN" {
                    self.allVehicles = result.sorted(by: { $0.vin < $1.vin})
                }else{
                    self.allVehicles = result.sorted(by: { $0.carType < $1.carType})
                }
                isLoading = false
             
            } catch {
            
                // Error handling in case the data couldn't be loaded
                // For now, only display the error on the console
                print("Error: \(String(describing: error))")
                isLoading=false
            }
        }
        
    //MARK: - Sorting function for carType
    func sortByCarType(){
        sortOption = .carType
        self.allVehicles = self.allVehicles.sorted(by: { $0.carType < $1.carType})
    }
    
    //MARK: - Sorting function for VIN
    func sortByVin(){
        sortOption = .vin
        self.allVehicles = self.allVehicles.sorted(by: { $0.vin < $1.vin})
    }
    
    //MARK: - Input value validation
    func validate(input: Int?) -> Bool {
        guard let input = input else {
                    return false
                }
                //Check and return valid or not
                let minInputVal = 1
                let maxInputVal = 100
                let validRange = minInputVal...maxInputVal
                return validRange.contains(input)
    }
    
    //MARK: - Calculate Carbon Emission
    func estimateCarbonEmissions(kilometrage: Int) -> String {
        let thresholdValue = 5000
        if kilometrage <= thresholdValue {
            return String(kilometrage)
        } else {
            //Extra emission for each kilometer after the threshold value 5000
            let extraKilometer = Double(kilometrage - thresholdValue)
            return String(thresholdValue + Int(extraKilometer * 1.5))
        }
    }
   
    //This function is use to show the color of a vehicle in the round circle. It has more colors in API but I have set limited colors to it and if no color is found then by default it will show gray color.
    func colorToUse(_ color: String) -> Color {
        switch color {
        case "Blue":
            return .blue
        case "Red":
            return .red
        case "Green":
            return .green
        case "Yellow":
            return .yellow
        case "Orange":
            return .orange
        case "Black":
            return .black
        case "White":
            return .white
        default:
            return .gray
        }
    }
    
}
