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
    
    var userToAssist : User? = nil
    
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
        
   
        
        FirebaseManager.sharedInstance.getUserById(userId: "39fkYXRAyHSsntJHMFl6EOrZSIW2", completion: { (user: User) -> Void in
            self.userToAssist =  user
            print("Loading user with name : "+(user.name)!)
            self.userToAssistName.text = self.userToAssist?.name;
          //  self.userTaskDescription.text = self.userToAssist?.task?.description;
           
        })
      //        //  print("Loading user with name : "+(user.)!)
      //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func assistUser(){
        print("You offered to assist" + (self.userToAssist?.name)!)
        
    }
}

