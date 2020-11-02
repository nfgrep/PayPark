//
//  Parking.swift
//  PayPark
//
//  Created by Nathan FG on 2020-10-09.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Parking : Codable, Hashable {
    @DocumentID var id = UUID().uuidString
    var email: String = ""
    var carPlate: String = ""
    var buildingCode: String = ""
    var unitNumber: String = ""
    var parkingDate = Date()
    var duration: Int = 0
    var parkingLocation: String = ""
    var parkingLat: Double = 0.0
    var parkingLong: Double = 0.0
    
    init(){}
    
    init(email: String, carPlate: String, buildingCode: String, unitNumber: String, parkingDate: Date, duration: Int, parkingLocation: String){
        self.email = email
        self.carPlate = carPlate
        self.buildingCode = buildingCode
        self.unitNumber = unitNumber
        self.parkingDate = parkingDate
        self.duration = duration
        self.parkingLocation = parkingLocation
    }
}
