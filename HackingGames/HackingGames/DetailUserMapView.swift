//
//  DetailUserMapView.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 27/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation
import UIKit


protocol UserMapProtocol {
    func userHasRequestedHelp(user : User)
}
class DetailUserMapView: UIView {
    
    var delegate : UserMapProtocol?
    
    var user : User?
    {
        didSet {
           updateInformation()
        }
    }
    
    @IBOutlet var photoView : UIImageView!
    @IBOutlet var distanceLabel : UILabel!
    @IBOutlet var userNameLabel : UILabel!
    @IBOutlet var taskTypeLabel : UILabel!
    @IBOutlet var taskDescriptionLabel : UILabel!
    @IBOutlet var descriptionLabel : UILabel!
    @IBOutlet var disabilityLabel : UILabel!
    @IBOutlet var helpButton : UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func updateInformation()
    {
        updateDistance()
        
        self.photoView.sd_setImage(with: URL(string: (user?.photoUrl)!))
        
        self.userNameLabel.text = self.user?.name
        self.taskTypeLabel.text = self.user?.task?.type == TaskType.Urgent ? "Urgent" : "Anytime"
        self.taskDescriptionLabel.text = self.user?.task?.description
        self.descriptionLabel.text = self.user?.description
        self.disabilityLabel.text = self.user?.disability
        
        self.taskTypeLabel.textColor = self.user?.task?.type == TaskType.Urgent ? UIColor.red : UIColor.lightGray
        
        self.helpButton.setTitle("HELP", for: UIControlState.normal)
        self.helpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        self.photoView.layer.cornerRadius = self.photoView.frame.size.width / 2;
        self.photoView.layer.masksToBounds = true 
        
        self.helpButton.backgroundColor = Constants.blueColor
        
        self.helpButton.addTarget(self, action: #selector(DetailUserMapView.userRequestHelp), for: UIControlEvents.touchUpInside)
    
    }
    
    func updateDistance()
    {
        DispatchQueue.main.async {
            let coordinate1 = CLLocation(latitude: (self.user?.location.coordinate.latitude)!, longitude:  (self.user?.location.coordinate.longitude)!)
            
            let coordinate2 = CLLocation(latitude: (LocationService.sharedInstance().locationManager.location?.coordinate.latitude)!, longitude: (LocationService.sharedInstance().locationManager.location?.coordinate.longitude)!)
            
            let distanceInMeters = coordinate2.distance(from: coordinate1)
        
            self.distanceLabel.text = NSString(format: " %.2f km",distanceInMeters/1000) as String
        }
    }
    
    func userRequestHelp()
    {
        self.delegate?.userHasRequestedHelp(user: self.user!)
    }
    
}
