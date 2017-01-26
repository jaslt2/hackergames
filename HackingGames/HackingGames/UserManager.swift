//
//  UserManager.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

protocol UserSignInDelegate {
    
    func existingUserIsSigned()
    func newUserIsSigned()
    
}
class UserManager : NSObject
{
    var delegate:UserSignInDelegate? = nil
    
    private (set) var user : FIRUser? = nil
    
    static let sharedInstance = UserManager()
    
    override init(){
        super.init()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func getFirebaseUser() -> FIRUser?
    {
        return FIRAuth.auth()?.currentUser
    }
    func userIsLogged() -> Bool
    {
        if (FIRAuth.auth()?.currentUser?.uid) != nil
        {
            return true
        }
        return false
    }
    
    func createUser(){
        print("Creating new user")

        if let user:FIRUser = getFirebaseUser()
        {
        FIRDatabase.database().reference().child("users").child((user.uid)).setValue(["displayName": user.displayName ?? "", "email": user.email ?? "", "photoURL": user.photoURL?.absoluteString ?? "", "location": ["lat": "51.5033640", "long" : "-0.1276250"]])
        self.delegate?.newUserIsSigned()
        }
    }
    
    func disconnectUser()
    {
        try! FIRAuth.auth()?.signOut()
      //  self.delegate?.userIsDisconnected()
    }
    
     func checkIfUserExistAlready()
    {
        // Lookup existing users
        if let userID = FIRAuth.auth()?.currentUser?.uid
        {
        FIRDatabase.database().reference().child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            if value == nil{
                print("User " + userID + " does not exist yet")
                self.createUser()
            } else {
                print("User " + userID + " already exists")
                self.delegate?.existingUserIsSigned()
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        }
    }
    
    func updateDisabilityFlag(disability: Disability){
        print("Updating disability flag")
        if let user : FIRUser = self.getFirebaseUser()
        {
        FIRDatabase.database().reference().child("users/" + user.uid + "/hasDisability").setValue(disability.rawValue)
        }
    }
}

extension UserManager : GIDSignInDelegate
{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if error != nil {
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if error != nil {
                return
            }
            
            self.checkIfUserExistAlready()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        self.disconnectUser()
    }
}
