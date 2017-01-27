//
//  UserHelpView.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 27/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation
import UIKit

class UserHelpView: UIView {
    
    var user : User?
        {
        didSet {
            updateInformations()
        }
    }
    
    @IBOutlet var profilePictureImageView : UIImageView!
    @IBOutlet var helpMessageLabel : UILabel!
    @IBOutlet var taskDescriptionLabel : UILabel!
    @IBOutlet var callButton : UIButton!
    @IBOutlet var sendMessageButton : UIButton!

    class func instanceFromNib() -> UserHelpView {
        return UINib(nibName: "UserHelpView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserHelpView
    }
    
    func loadFromNib()
    {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UserHelpView", bundle: bundle)
        print(nib.description)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        self.addSubview(view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib()
    }
    
    func updateInformations()
    {
        self.callButton.backgroundColor = Constants.blueColor

        self.callButton.setTitle("CALL " + (self.user?.name)!, for: UIControlState.normal)
        self.callButton.addTarget(self, action: #selector(UserHelpView.callUser), for: UIControlEvents.touchUpInside)
        
        
        self.sendMessageButton.setTitle("Send message", for: UIControlState.normal)
        self.sendMessageButton.setTitleColor(Constants.blueColor, for: UIControlState.normal)
        
        self.profilePictureImageView.layer.cornerRadius = self.profilePictureImageView.frame.size.width / 2;
        self.profilePictureImageView.layer.masksToBounds = true
        
        self.profilePictureImageView.sd_setImage(with: URL(string: (user?.photoUrl)!))
        
        self.helpMessageLabel.text = "Thank you for helping " + (self.user?.name?.capitalized)!
        self.taskDescriptionLabel.text = self.user?.task?.description
     
        self.sizeToFit()
    }

    func callUser()
    {
         self.removeFromSuperview()
        
        if let tel = self.user!.phoneNumber
        {
        let url = NSURL(string: "tel://\(tel)")
        
       if UIApplication.shared.canOpenURL(url as! URL) {
            UIApplication.shared.openURL(url as! URL)
        }
        }
    }
}
