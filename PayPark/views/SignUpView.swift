//
//  SignUpView.swift
//  PayPark
//
//  Created by Jigisha Patel on 2020-09-21.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var carPlate: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
//        NavigationView{
            VStack{
                Form{
                    Section(header: Text("Personal Information")){
                        TextField("Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Car Plate", text:$carPlate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.allCharacters)
                        
                        TextField("Email", text:$email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                    }
                    
                    Section(header: Text("Password Information")){
                        SecureField("Password", text:$password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        SecureField("Confirm Password", text:$confirmPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }//Form
                .disableAutocorrection(true)
                
                Section{
                    Button(action:{
                        print("Creating Account")
                        if (self.validateData()){
                            self.addNewUser()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }){
                        Text("Create Account")
                            .accentColor(Color.white)
                            .padding()
                            .background(Color(UIColor.darkGray))
                            .cornerRadius(5.0)
                    }
                }//Section
            }//VStack
            .navigationBarTitle("Sign Up",
                                displayMode: .inline).font(.headline)
//        }//NavigationView
    }
    
    func validateData() -> Bool{
        //TODO for data validation - Take Home
        
        if (self.password != self.confirmPassword){
            return false
        }
        
        return true
    }
    
    func addNewUser(){
        //TODO for adding a new user account
        self.userViewModel.insertUser(name: self.name,email: self.email, carPlate: self.carPlate,password: self.password)
        
        //pop current view from the stack
        //self.presentationMode.wrappedValue.dismiss()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
