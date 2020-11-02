//
//  ParkingViewModel.swift
//  PayPark
//
//  Created by Nathan FG on 2020-10-09.
//

import Foundation
import Firebase
import SwiftUI
import os

class ParkingViewModel: ObservableObject{
    @Published var parkingList = [Parking]()
    @EnvironmentObject var userSettings: UserSettings
    
    private var db = Firestore.firestore()
    private let COLLECTION_NAME = "Parkings"
    
    func addParking(newParking: Parking){
        do{
            var docRef = try db.collection("Parkings").addDocument(from: newParking)
        }catch let error as NSError{
            print(#function,"Error creating document: \(error.localizedDescription)")
        }
    }
    
    func getAllParkings(){
        let email = UserDefaults.standard.string(forKey: "KEY_EMAIL")
        
        db.collection(COLLECTION_NAME)
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
                            if(!self.parkingList.contains(parking)){
                                self.parkingList.append(parking)
                            }
                        }
                        
                        if doc.type == .modified{
                            //TODO: for updated document
                        }
                        
                        if doc.type == .removed{
                            //TODO: for deleted document
                            let docID = doc.document.documentID
                            let index = self.parkingList.firstIndex(where: {
                                ($0.id?.elementsEqual(docID))!
                            })
                            if(index != nil){
                                self.parkingList.remove(at: index!)
                            }
                        }
                        
                        self.parkingList.sort{ (currentObj, nextObj) in
                            currentObj.parkingDate > nextObj.parkingDate
                        }
                        
                    }catch let error as NSError{
                        print("Error decoding document: \(error.localizedDescription)")
                    }
                    
                }
        })
        
        print(#function, "Parking List : ", self.parkingList)
    }
    
    func deleteParking(index: Int){
        db.collection(COLLECTION_NAME)
            .document(self.parkingList[index].id!)
            .delete{ (error) in
                if let error = error {
                    Logger().error("Error deleting document \(error.localizedDescription)")
                } else{
                    Logger().debug("Document successfully deleted")
                }
        }
    }
    
    func updateParking(parking: Parking, index: Int){
        db.collection(COLLECTION_NAME)
            .document(self.parkingList[index].id!)
            .updateData(["buildingCode" : parking.buildingCode,
                         "parkingDate" : parking.parkingDate,
                         "unitNumber" : parking.unitNumber,
                         "carPlate" : parking.carPlate,
                         "duration" : parking.duration,
                         "parkingLocation" : parking.parkingLocation
            ]){ (error) in
                if let error = error{
                    Logger().error("Error updating document: \(error.localizedDescription)")
                }else{
                    Logger().debug("Document successfully updated.")
                }
            }
    }
}
