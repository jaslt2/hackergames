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
    
    var userToAssist : User?
    
    @IBOutlet weak var profilePicture: UIImageView!
 
    @IBOutlet weak var userToAssistName: UILabel!
    
    @IBOutlet weak var userTaskDescription: UILabel!
    @IBOutlet weak var userToAssistDesc: UILabel!
    @IBOutlet weak var userTaskname: UILabel!
    
    @IBOutlet weak var disabilityName: UILabel!
    
    @IBOutlet weak var disabilityInfo: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var whatINeedTitle: UILabel!

    @IBAction func helpButtonPressed(_ sender: Any) {
        self.assistUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photo.layer.cornerRadius = self.photo.frame.size.width / 2;
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        fillUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fillUser()
    {
        FirebaseManager.sharedInstance.getUserById(userId: (self.userToAssist?.userId)!, completion: { (user: User) -> Void in
          
            if let task = user.task
            {
                self.userTaskDescription.text = (task.description)
                self.userTaskname.text = (task.name)!
            }

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
    
    
    func assistUser(){
        self.dismiss(animated: true, completion:nil)
        print("You offered to assist" + (self.userToAssistName.text)!)
        
    }
}

