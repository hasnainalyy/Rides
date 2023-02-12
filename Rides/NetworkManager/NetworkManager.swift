//
//  NetworkManager.swift
//  Rides
//
//  Created by Ali Hussain on 2023-02-09.
//

import Foundation

struct NetworkManager {
    
    //Singleton for networking
       static let sharedManager = NetworkManager()
    
    //MARK: - Async Network Call
    func fetch<T: Codable>(from endPoint: String) async throws -> T {
     
        //Create the full url
        guard let url = URL(string: Constant.baseUrl+endPoint) else  {
            throw URLError(.badURL)
        }
        
     
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        //Get data and JSON Parsing
        let result = try JSONDecoder().decode(T.self, from: data)
          
        return result
    }
    
}
