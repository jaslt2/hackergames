//
//  User.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation

struct User
{
    private (set) var name : String?
    private (set) var description : String?
    private (set) var email : String?
    private (set) var location : CLLocation!
    private (set) var photoUrl : String?
    
    private (set) var task : Task?
    
    init(infos : NSDictionary)
    {
        self.name = infos["displayName"] as? String
        
        self.email = infos["email"] as? String
        
        self.photoUrl = infos["photoURL"] as? String
        
        if(infos["location"] != nil)
        {
        let infoLocation : NSDictionary = (infos["location"] as? NSDictionary)!
        
        let latitude : CLLocationDegrees = infoLocation["lat"] as! CLLocationDegrees
        let longitude : CLLocationDegrees = infoLocation["long"] as! CLLocationDegrees
        
        self.location = CLLocation(latitude:latitude,longitude:longitude)
        }
        
        if(infos["task"] != nil)
        {
        let taskInfo : NSDictionary = infos["task"]  as! NSDictionary
        
        let taskType : Int = taskInfo["urgent"] as! Int
        
        let taskStatus : String = taskInfo["status"] as! String
        
        self.task = Task(desc: "", status: taskStatus, type: taskType)
        }
    }

}
