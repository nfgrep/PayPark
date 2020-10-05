//
//  HomeView.swift
//  PayPark
//
//  Created by Jigisha Patel on 2020-09-21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userSettings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userViewModel: UserViewModel
    
    
    @State private var selection: Int? = 0
    
    var email: String = ""
    
    var body: some View {
        NavigationLink(destination: SignInView(), tag: 1, selection: $selection){}
        
        Text("Hello, \(self.userSettings.userEmail)")
        List{
            
        }
        Button(action:{
            print("Add parking")
        }){
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(Color(red: 0.6, green: 0.6, blue: 1))
                .shadow(color: .gray, radius: 0.5, x: 0.5, y: 1)
        }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Menu{
                        Button("Delete Account", action: self.deleteAccount)
                        Button("Edit Profile", action: self.editProfile)
                        Button("Sign Out", action: self.signOut)
                    }label:{
                        Image(systemName: "gear")
                    }
                }
            }
    }
    
    private func deleteAccount(){
        self.userViewModel.deleteUser()
        self.selection = 1
        UserDefaults.standard.removeObject(forKey: "KEY_EMAIL")
        UserDefaults.standard.removeObject(forKey: "PAYPARK_PASSWORD")
    }
    
    private func editProfile(){
        self.userViewModel.loggedInUser?.carPlate = "CHER2020"
        self.userViewModel.loggedInUser?.name = "Bartholomew"
        self.userViewModel.updateUser()
    }
    
    private func signOut(){
        self.selection = 1
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}