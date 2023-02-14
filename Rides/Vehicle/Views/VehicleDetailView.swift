//
//  VehicleDetailView.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-09.
//

import SwiftUI

struct VehicleDetailView: View {
    
    @ObservedObject private var vehicleVM = VehicleViewModel(networkManager: NetworkManager.sharedManager)
    var vehicle:Vehicle
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            
            ZStack(alignment: .trailing){
                
                VStack(alignment: .center,spacing: 0){
                    
                    HStack{
                        VStack(spacing:8){
                            
                        
                            Text(vehicle.carType)
                                .font(.title.bold())
                                .lineLimit(1)
                         
                            
                            Image("car")
                                .resizable()
                                .scaledToFit()
                            
//                            Image(systemName: "arrow.right.circle.fill")
//                                .resizable()
//                                .frame(width: 32,height: 32)
                              
                        
                            
                            HStack{
                                
                                if let color = vehicle.color {
                                    Circle()
                                        .frame(width: 24,height: 24)
                                        .foregroundColor(vehicleVM.colorToUse(color))
                                }
                              
                                Text(vehicle.color ?? "N/A")
                                    .lineLimit(1)
                                    .font(.headline.bold())
                                    .foregroundColor(Color.black)
                            }
                            
                            Text("VIN: \(vehicle.vin)")
                                .lineLimit(1)
                                .font(.headline.bold())
                                .foregroundColor(Color.gray)
                                .padding(.leading,24)
                            
                        }
                       
                    }
                    
                }//VStack
                .padding()
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
                
                
            }
          
               
            
        }//scrollView
     
    }
    
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView(vehicle: Vehicle(id: 2, vin: "213123111", carType: "Sedan", makeAndModel: "Audi A5", color: "Blue", kilometrage: 1312311))
    }
}

                                          
