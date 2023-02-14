//
//  VehiclePageView.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-13.
//

import SwiftUI
import UIKit

struct VehiclePageView: View {
    
    var vehicle:Vehicle
    @State private var currentPage = 0
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text(vehicle.makeAndModel ?? "N/A")
                .font(.largeTitle.bold())
                .lineLimit(1)
                .padding(.horizontal)
            
            PageView(pages: [AnyView(VehicleDetailView(vehicle: vehicle))
                ,AnyView(CarbonEmissionView(kilometrage: vehicle.kilometrage))], currentPage: $currentPage)
        
            
        }//Vstack
    }
}
    
       
struct VehiclePageView_Previews: PreviewProvider {
    static var previews: some View {
        VehiclePageView(vehicle: Vehicle(id: 2, vin: "213123111", carType: "Sedan", makeAndModel: "Audi A5", color: "Blue", kilometrage: 10000))
    }
}


