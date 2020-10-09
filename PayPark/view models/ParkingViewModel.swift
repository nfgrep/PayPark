//
//  ParkingViewModel.swift
//  PayPark
//
//  Created by Nathan FG on 2020-10-09.
//

import Foundation
import Firebase
import SwiftUI

class ParkingViewModel: ObservableObject{
    @Published var parkingList = [Parking]()
    @EnvironmentObject var userSettings: UserSettings
    
    private var db = Firestore.firestore()
    
    func addParking(newParking: Parking){
        do{
            var docRef = try db.collection("Parkings").addDocument(from: newParking)
        }catch let error as NSError{
            print(#function,"Error creating document: \(error.localizedDescription)")
        }
    }
    
    func getAllParkings(){
        let email = UserDefaults.standard.string(forKey: "KEY_EMAIL")
        
        db.collection("Parkings")
            .whereField("email", isEqualTo: email as Any)
            .order(by: "parkingDate", descending: true)
            .addSnapshotListener({ (querySnapshot, error) in
            guard let snapshot = querySnapshot else{
                print(#function,"Error fetching documents: \(error?.localizedDescription)")
                return
            }
            //successfully received documents
                snapshot.documentChanges.forEach{(doc) in
                    var parking = Parking()
                    do{
                        parking = try doc.document.data(as: Parking.self)!
                        
                        if doc.type == .added{
                            self.parkingList.append(parking)
                        }
                        
                        if doc.type == .modified{
                            //TODO: for updated document
                        }
                        
                        if doc.type == .removed{
                            //TODO: for deleted document
                        }
                        
                    }catch let error as NSError{
                        print("Error decoding document: \(error.localizedDescription)")
                    }
                    
                }
        })
        print(#function, "Parking List : ", self.parkingList)
    }
}
