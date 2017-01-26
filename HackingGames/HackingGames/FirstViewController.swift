//
//  FirstViewController.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class FirstViewController: UIViewController, GIDSignInUIDelegate,GIDSignInDelegate {
    
    let disabilitySegue : String = "SignInToDisabilityFilterSegue"
    
    var user : FIRUser? = nil
    
    @IBOutlet weak var signInButton: GIDSignInButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
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
            
            self.user = user
            self.performSegue(withIdentifier: self.disabilitySegue, sender: self)
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: Error!) {}

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController : SecondViewController = segue.destination as! SecondViewController
        viewController.user = self.user
        
    }
}

