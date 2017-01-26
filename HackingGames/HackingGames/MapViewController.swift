//
//  MapViewController.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation
import MapKit
import Firebase

class MapViewController: UIViewController {
    
    private let disabilitySegue : String = "SignInToDisabilityFilterSegue"
    
    private var user : FIRUser? = nil
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.user = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInTheUserIfRequired()
    }
    
    func signInTheUserIfRequired()
    {
        if !UserManager.sharedInstance.userIsLogged() {
            self.performSegue(withIdentifier: disabilitySegue, sender: self)
        }
    }

}
