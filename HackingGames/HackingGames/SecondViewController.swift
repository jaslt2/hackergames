//
//  SecondViewController.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SecondViewController: UIViewController {

    var user : FIRUser!
    
    @IBOutlet weak var nodisability: UIButton!
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = "Hi " + user.displayName! + "do you have a disability?";
        self.updateDisabilityFlag(hasDisability: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateDisabilityFlag(hasDisability: Bool){
        print("Updating disability flag")
        FIRDatabase.database().reference().child("users/" + self.user.uid + "/hasDisability").setValue(hasDisability)
    }
}

