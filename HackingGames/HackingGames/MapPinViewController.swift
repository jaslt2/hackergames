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
    
   // var userToAssist : User? = nil
    
    @IBOutlet weak var profilePicture: UIImageView!
 
    @IBOutlet weak var userToAssistName: UILabel!
    
    @IBOutlet weak var userTaskDescription: UILabel!
    @IBOutlet weak var userToAssistDesc: UILabel!
    @IBOutlet weak var userTaskname: UILabel!
    
    @IBOutlet weak var disabilityName: UILabel!
    
    @IBOutlet weak var disabilityInfo: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBAction func helpButtonPressed(_ sender: Any) {
      //  assistUser()
        print("You clicked the button")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        FirebaseManager.sharedInstance.getUserById(userId: "39fkYXRAyHSsntJHMFl6EOrZSIW2", completion: { (user: User) -> Void in
         //   self.userToAssist =  user
            print("Loading user with task desription: "+(user.task?.description)!)
            self.userToAssistName.text = user.name;
            self.userTaskDescription.text = (user.task?.description)!
            self.userTaskname.text = (user.task?.name)!
            self.userBio.text = user.description
            self.disabilityName.text = user.disability
            self.disabilityInfo.text = user.disabilityInfo
            if let url = NSURL(string: user.photoUrl!) {
                if let data = NSData(contentsOf: url as URL) {
                    self.photo.image = UIImage(data: data as Data)
                }
            }
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func assistUser(){
        print("You offered to assist" + (self.userToAssistName.text)!)
        
    }
}

