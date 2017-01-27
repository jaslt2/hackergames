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
    let profileSegue : String = "SigninToCreateProfileSegue"

    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var signInButton : UIButton!
    @IBOutlet weak var googleSignInButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        UserManager.sharedInstance.delegate = self
        
        self.signInButton.layer.borderWidth = 1
        self.signInButton.layer.borderColor = UIColor.white.cgColor
        
        self.googleSignInButton.layer.borderWidth = 1
        self.googleSignInButton.layer.borderColor = UIColor.white.cgColor
        
        addBorderLine(textField: emailTextField)
        addBorderLine(textField: passwordTextField)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBorderLine(textField : UITextField)
    {
        let border : CALayer = CALayer()
        border.borderWidth = 1
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - border.borderWidth, width: textField.frame.size.width, height:  textField.frame.size.height)
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    @IBAction func signInWithGoogle(sender : UIButton)
    {
      GIDSignIn.sharedInstance().signIn()
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
            self.performSegue(withIdentifier: profileSegue, sender: self)
        case 1:
            UserManager.sharedInstance.updateDisabilityFlag(disability: Disability.NONE)
            self.dismiss(animated: true) {}
        default:
            break
        }
    }

}
