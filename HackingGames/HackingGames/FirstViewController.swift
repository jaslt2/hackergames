//
//  FirstViewController.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var HelloView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        FirebaseManager.sharedInstance.getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

