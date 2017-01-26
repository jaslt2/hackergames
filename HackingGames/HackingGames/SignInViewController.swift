//
//  SignInViewController.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class SignInViewController : UIViewController,GIDSignInUIDelegate,UserSignInDelegate
{

    @IBOutlet weak var signInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        UserManager.sharedInstance.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func existingUserIsSigned()
    {
        self.dismiss(animated: true) {}
    }
    
    func newUserIsSigned() {
        
        let actionSheet = UIActionSheet(title: "Do you have disability", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil, otherButtonTitles: "YES", "NO")
        actionSheet.show(in:self.view)
    }

}

extension SignInViewController : UIActionSheetDelegate
{
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
        switch buttonIndex {
        case 0:
            UserManager.sharedInstance.updateDisabilityFlag(disability: Disability.HAVE)
        case 1:
            UserManager.sharedInstance.updateDisabilityFlag(disability: Disability.NONE)
        default:
            break
        }
        
        self.dismiss(animated: true) {}
    }
    
}
