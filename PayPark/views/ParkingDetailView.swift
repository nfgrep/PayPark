//
//  ParkingDetailView.swift
//  PayPark
//
//  Created by Nathan FG on 2020-10-16.
//

import SwiftUI

struct ParkingDetailView: View {
    var parking: Parking
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("\(Formatter().simplifiedDateFormatter(date: parking.parkingDate))")
                .fontWeight(.bold)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
            Text("Building Code: \(parking.buildingCode)")
            Text("Unit Number: \(parking.unitNumber)")
            Text("Car Plate: \(parking.carPlate)")
            Text("Duration: \(parking.duration)")
            Text("Location: \(parking.parkingLocation)")
                .fontWeight(.bold)
        }
        .navigationBarTitle(Text("Parking Details"))
    }
}

struct ParkingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingDetailView(parking: Parking())
    }
}
