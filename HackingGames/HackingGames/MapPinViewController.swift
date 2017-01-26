//
//  MapPinViewController.swift
//  HackingGames
//
//  Created by Gilly Ames on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//
//

import UIKit
import Firebase
import FirebaseAuth

class MapPinViewController: UIViewController {
    
    var userToAssist : FIRUser? = nil
    
    @IBOutlet weak var profilePicture: UIImageView!
 
    @IBOutlet weak var userToAssistName: UILabel!
    
    @IBOutlet weak var userTaskDescription: UILabel!
    @IBOutlet weak var userToAssistDesc: UILabel!
    @IBOutlet weak var userTaskname: UILabel!
    @IBAction func helpButtonPressed(_ sender: Any) {
      //  assistUser()
        print("You clicked the button")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userToAssist = FirebaseManager.sharedInstance.getUserById(userId: UserManager.sharedInstance.getFirebaseUser().uid, completion: { (user : User) in
            
        })
        self.userToAssistName.text = self.userToAssist?.displayName;
      //  self.userTaskDescription.text = self.userToAssist?.task.description;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func assistUser(){
        print("You offered to assist" + (self.userToAssist?.displayName)!)
        
    }
}

