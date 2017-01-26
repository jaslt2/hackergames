//
//  FirebaseManager.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FirebaseManager {
    
    private (set) var databaseReference : FIRDatabaseReference!
    
    static let sharedInstance = FirebaseManager()
    
    private init()
    {
        self.databaseReference = FIRDatabase.database().reference()
    }
    
    func getUsers(completion:@escaping (_ user : [User]) -> Void)
    {
        self.databaseReference.child("users").observeSingleEvent(of: .value, with: { (snapshot) in

            let value = snapshot.value as? NSDictionary

            let listUsers : NSMutableArray = NSMutableArray()
            
            for  infoUser in value!
            {
            let user : User  = User(infos: infoUser.value as! NSDictionary)
                
            listUsers.add(user)
            }
            completion((listUsers as NSArray) as! [User])
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getUserById(userId : String, completion:@escaping (_ user : User) -> Void)
    {
        self.databaseReference.child("users/"+userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            print (value ?? "")
            
             let user : User  = User(infos: value! )
            
             completion(user)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
}
