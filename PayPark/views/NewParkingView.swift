//
//  NewParkingView.swift
//  PayPark
//
//  Created by Nathan FG on 2020-10-09.
//

import SwiftUI

struct NewParkingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var parkingViewModel: ParkingViewModel
    
    @State private var buildingCode: String = ""
    @State private var carPlate: String = ""
    @State private var unitNumber: String = ""
    @State private var parkingDate = Date()
    @State private var duration: Int = 0
    @State private var parkingLocation: String = ""
    
    let durationHours = [4,8,10,24]
    
    var body: some View {
        VStack{
            Form{
                Section{
                    TextField("Car Plate", text: $carPlate)
                    TextField("Building Code", text: $buildingCode)
                    TextField("Unit Number", text: $unitNumber)
                    DatePicker(selection: $parkingDate, in: ...Date()){
                        Text("Parking Date")
                    }
                }
                Section(header: Text("Duration of parking")){
                    Picker(selection: $duration, label: Text("Duration"), content:{
                        ForEach(0 ..< durationHours.count){ item in
                            Text("\(durationHours[item]) hours")
                        }
                    }).pickerStyle(SegmentedPickerStyle())
                }
                Section{
                    HStack{
                        TextField("Parking Location", text: $parkingLocation)
                        Button(action: {
                            self.getLocation()
                        }){
                            Image(systemName: "location")
                        }
                    }
                }
            }//Form
            
            Button(action: {
                self.addParking()
            }){Text("Add Parking")}
            
        }//Vstack
    }//body
    private func addParking(){
        var newParking = Parking()
        newParking.email = self.userSettings.userEmail
        newParking.carPlate = self.carPlate
        newParking.buildingCode = self.buildingCode
        newParking.unitNumber = self.unitNumber
        newParking.duration = self.duration
        newParking.parkingLocation = self.parkingLocation
        newParking.parkingDate = self.parkingDate
        print(#function, "New parking: \(newParking)")
        
        parkingViewModel.addParking(newParking: newParking)
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func getLocation(){
        print(#function, "Getting Location")
        
    }
}

struct NewParkingView_Previews: PreviewProvider {
    static var previews: some View {
        NewParkingView()
    }
}
