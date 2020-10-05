//
//  UserViewModel.swift
//  PayPark
//
//  Created by Jigisha Patel on 2020-09-28.
//

import Foundation
import CoreData
import SwiftUI
import UIKit

public class UserViewModel : ObservableObject {
    @Published var loggedInUser : User?
    @Published var userList = [User]()
    
    private let moc: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertUser(name: String, email: String, carPlate: String, password: String){
        do{
            //Casting a NSManagedObject to its model entity works!
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: moc) as! User
            
            newUser.email = email
            newUser.name = name
            newUser.carPlate = carPlate
            newUser.password = password
            
            try moc.save()
            
            print("User Account Successfully Created")
            
        }catch let error as NSError{
            print("Something went wrong. Couldn't create account.")
            print("\(error), \(error.localizedDescription)")
        }
    }
    
    func findUserByEmail(email: String){
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        
        //Filters, WHERE
        let predicate = NSPredicate(format: "email == %@",email)
        fetchRequest.predicate = predicate
        
        do{
            if let matchedUser = try moc.fetch(fetchRequest).first{
                self.loggedInUser = matchedUser
                print("Matching User Found")
            }
            
        }catch let error as NSError{
            print("Something went wrong...")
            print("\(error), \(error.localizedDescription)")
        }
    }
    
    func getAllUsers(){
        let fetchReq = NSFetchRequest<User>(entityName: "User")
        
        do{
            let result = try moc.fetch(fetchReq)
            self.userList = result
        }catch let error as NSError{
            print(#function,"Couldnt fetch: \(error.localizedDescription)")
        }
    }
    
    func updateUser(){
        do{
            try moc.save()
            print(#function, "User updated")
        }catch let error as NSError{
            print(#function, "Unable to update user: \(error.localizedDescription)")
        }
    }
    
    func deleteUser(){
        do{
            moc.delete(loggedInUser! as NSManagedObject)
            try moc.save()
            
            print(#function, "User Deleted...")
        }catch let error as NSError{
            print(#function, "Cannot delete user: \(error.localizedDescription)")
        }
    }
    
}
