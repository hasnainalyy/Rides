//
//  CarbonEmissionView.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-13.
//

import SwiftUI

struct CarbonEmissionView: View {
    
    
    @ObservedObject private var vehicleVM = VehicleViewModel(networkManager: NetworkManager.sharedManager)
    
    var kilometrage:Int
    
    var body: some View {
        
        
        ScrollView {
            
            
            VStack(spacing:16){
                
                Text(Constant.emissionDetails)
                    .font(.title3.bold())
                    
                
                Text(Constant.estimatedCarbonEmission)
                    .font(.headline)
                
                
                Text(String(vehicleVM.estimateCarbonEmissions(kilometrage: kilometrage)))
                    .font(.largeTitle.bold())
                    .foregroundColor(.gray)
                
            }//VStack
            .padding(.vertical,24)
            .padding(.horizontal,16)
            .frame(maxWidth: .infinity)
            .background(
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(24)
                    .shadow(
                        color: Color.gray.opacity(0.4),
                        radius: 8,
                        x: 0,
                        y: 0
                    )
            )
            .padding()
            
        }//VStack
        
    }
}


struct CarbonEmissionView_Previews: PreviewProvider {
    static var previews: some View {
        CarbonEmissionView(kilometrage: 5300)
    }
}
