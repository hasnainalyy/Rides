//
//  RidesTests.swift
//  RidesTests
//
//  Created by Ali Hussain on 2023-02-09.
//

import XCTest
@testable import Rides

final class RidesTests: XCTestCase {
    
    
    var vehicleViewModel: VehicleViewModel!

    override func setUpWithError() throws {
        vehicleViewModel = VehicleViewModel(networkManager: NetworkManager.sharedManager)
    }

    override func tearDownWithError() throws {
        vehicleViewModel = nil
    }

    //MARK: - Test for Inputfield validation
    func testWhenInputIsInValidRange() throws {
      
        let input = 50
        let result = vehicleViewModel.validate(input: input)
        XCTAssertTrue(result, "Expected true when input is in valid range")
    }

    func testWhenInputIsLessThanValidRange() throws {
    
        let input = 0
        let result = vehicleViewModel.validate(input: input)
        XCTAssertFalse(result, "Expected false when input is less than valid range")
    }
    
    func testWhenInputIsNil() throws {
    
        let result = vehicleViewModel.validate(input: nil)
        XCTAssertFalse(result, "Expected false when input is nil")
    }

    func testWhenInputIsGreaterThanValidRange() throws {
    
        let input = 101
        let result = vehicleViewModel.validate(input: input)
        XCTAssertFalse(result, "Expected false when input is greater than valid range")
    }
    
    //MARK: - Test for Emission calculation
    
    func testCalculateCarbonEmissionForLessThan5000Kilometres() throws {
        //Expected emission calculation for kilometrage till 5000
        let expectedEmissionTillThreshold = String(5000)
        let carbonEmission = vehicleViewModel.estimateCarbonEmissions(kilometrage: 4000)
        XCTAssertEqual(carbonEmission,expectedEmissionTillThreshold)
     }
     
     func testCalculateCarbonEmissionForMoreThan5000Kilometres() throws {
        //Expected emission calculation for kilometrage beyond 5000
        let expectedEmissionBeyondThreshold = String(5000 + Int(1000 * 1.5))
        let carbonEmission = vehicleViewModel.estimateCarbonEmissions(kilometrage: 6000)
        XCTAssertEqual(carbonEmission,expectedEmissionBeyondThreshold)
     }
    
    
    
}
