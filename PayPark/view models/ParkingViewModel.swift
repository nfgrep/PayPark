//
//  ParkingViewModel.swift
//  PayPark
//
//  Created by Nathan FG on 2020-10-09.
//

import Foundation
import Firebase

class ParkingViewModel: ObservableObject{
    private var db = Firestore.firestore()
    
    func addParking(newParking: Parking){
        do{
            var docRef = try db.collection("Parkings").addDocument(from: newParking)
        }catch let error as NSError{
            print(#function,"Error creating document: \(error.localizedDescription)")
        }
    }
}
