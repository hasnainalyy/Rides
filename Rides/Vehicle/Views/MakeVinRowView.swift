//
//  MakeVinRowView.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-12.
//

import SwiftUI

struct MakeVinRowView: View {
    var item:Vehicle
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading,spacing: 8){
                Text(item.makeAndModel ?? "N/A")
                    .font(.title3.bold())
                    .lineLimit(1)
                    .padding(.top,8)
                Text(item.vin)
                    .lineLimit(1)
                    .font(.subheadline.bold())
                    .foregroundColor(Color.gray)
            }
            
            Spacer()
            
            
            Image(systemName: "chevron.right").foregroundColor(Color.gray)
            
            
        }//hStack
        .padding(.vertical,8)
        
        
        Divider().padding(.top,8)
    }
}




