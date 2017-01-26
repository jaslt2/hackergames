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
    
    private init() {
        self.databaseReference = FIRDatabase.database().reference()
    }
    
    func getUsers()
    {
        self.databaseReference.child("users").observeSingleEvent(of: .value, with: { (snapshot) in

            let value = snapshot.value as? NSDictionary
            
            print (value)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
