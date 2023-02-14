//
//  VehicleListView.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-09.
//

import SwiftUI
import Combine

struct VehicleListView: View {
    
    @StateObject private var vehicleVM = VehicleViewModel(networkManager: NetworkManager.sharedManager)
    
    var body: some View {
        NavigationView(){
            VStack{
                HStack(spacing:8){
                    TextField(Constant.inputHint, text: $vehicleVM.numberVehicle)
                        .padding(.horizontal)
                        .padding(.vertical,8)
                        .overlay(RoundedRectangle(cornerRadius: 24).stroke(.gray, lineWidth: 1))
                        .cornerRadius(24)
                        .keyboardType(.numberPad)
                        .onReceive(Just(vehicleVM.numberVehicle)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                vehicleVM.numberVehicle = filtered
                            }
                        }
                    
                    Button {
                        Task{
                            await vehicleVM.getVehicles(size: Int(vehicleVM.numberVehicle) ?? 10)
                        }
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .frame(width: 28,height: 28)
                    }
                    
                    
                    Menu {
                        Text(Constant.sortBy)
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        Button(Constant.VIN, action: vehicleVM.sortByVin)
                        Button(Constant.carType, action: vehicleVM.sortByCarType )
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .resizable()
                            .frame(width: 28,height: 28)
                    }
                    
                    
                }//hstack
                .padding(.horizontal,16).padding(.bottom,8)
                
                
                ScrollView(showsIndicators: false){
                    
                    // I have choose LazyVStack because of large dataset. Only load the views that are currently visible, resulting in faster and smoother scrolling, as well as reduced memory usage
                    LazyVStack(alignment: .leading,spacing: 0) {
                        
                        if !vehicleVM.allVehicles.isEmpty {
                            Text("\(String(format: Constant.vehicles, vehicleVM.sortOption.rawValue).uppercased())")
                                .font(.subheadline).foregroundColor(Color.gray)
                                .lineLimit(1)
                                .padding(.vertical)
                            
                            Divider()
                            
                            ForEach(vehicleVM.allVehicles, id: \.id) { item in NavigationLink(destination: VehiclePageView(vehicle: item)
                                ) {
                                    MakeVinRowView(item: item)
                                }.buttonStyle(PlainButtonStyle())
                               }
                        }
                        
                        
                    }//LazyVStack
                    .padding(.horizontal,16)
                    .background(Color.white)
                    .frame(maxHeight: .infinity,alignment: .top)
                    .padding(.vertical)
                    
                    
                    if vehicleVM.isLoading {
                        ProgressView()
                    }
                    
                }//scrollView
                .background(Color.gray.opacity(0.1))
                
                
            }//VStack
            .navigationTitle(Constant.findVehicles)
            .alert(vehicleVM.alertTitle, isPresented: $vehicleVM.showAlert) {}
            
            
        }//NavigationView
        
    }
    
   
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView()
    }
}


