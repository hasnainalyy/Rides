//
//  VehicleViewModel.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-09.
//

import Foundation
import SwiftUI

class VehicleViewModel: ObservableObject {
 
    var networkManager: NetworkManager
    @Published var allVehicles: [Vehicle] = []
    @Published var numberVehicle: String = ""
    @Published var sortOption: SortOption = .vin
    
    //for alert
    @Published var showAlert = false
    @Published var alertTitle = ""
    
    //API loading state
    @Published var isLoading = false
    
       //MARK: - Init
       init(networkManager: NetworkManager) {
           self.networkManager = networkManager
       }
       
    //MARK: - API - Get Vehicles
    @MainActor
    func getVehicles(size: Int = 10) async{
        
        let isValidate = validate(input: Int(numberVehicle) ?? 0)
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
        
    // sorting function for carType
    func sortByCarType(){
        sortOption = .carType
        self.allVehicles = self.allVehicles.sorted(by: { $0.carType < $1.carType})
    }
    
    // sorting function for VIN
    func sortByVin(){
        sortOption = .vin
        self.allVehicles = self.allVehicles.sorted(by: { $0.vin < $1.vin})
    }
    
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
