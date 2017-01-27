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


enum Disability : Int
{
    case HAVE = 1,NONE
}

struct User
{
    private (set) var userId : String?
    private (set) var name : String?
    private (set) var description : String?
    private (set) var email : String?
    private (set) var location : CLLocation!
    private (set) var photoUrl : String?
    private (set) var phoneNumber : String?
    private (set) var disability : String?
    private (set) var disabilityInfo : String?
    
    private (set) var task : Task?
    
    init(infos : NSDictionary, key : String)
    {
        self.userId = key
        
        self.name = infos["displayName"] as? String
        
        self.email = infos["email"] as? String
        
        self.photoUrl = infos["photoURL"] as? String
        
        self.phoneNumber = infos["phoneNumber"] as? String
        
        if(infos["disability"] != nil)
        {
            self.disability = infos["disability"] as? String
        }
        
        if(infos["disabilityInfo"] != nil)
        {
            self.disabilityInfo = infos["disabilityInfo"] as? String
        }
        
        if(infos["description"] != nil)
        {
            self.description = infos["description"] as? String
        }
        
        if(infos["location"] != nil)
        {
        let infoLocation : NSDictionary = (infos["location"] as? NSDictionary)!
        
        let latitude : String = (infoLocation["lat"] as? String)!
        let longitude : String = (infoLocation["long"] as? String)!
        
        self.location = CLLocation(latitude:Double(latitude)!,longitude:Double(longitude)!)
        }
        
        if(infos["task"] != nil)
        {
        let taskInfo : NSDictionary = infos["task"]  as! NSDictionary

        let taskType : NSNumber = (taskInfo["urgent"] as? NSNumber)!
        
        let taskStatus : String = taskInfo["status"] as! String
      
        let taskDescription : String = taskInfo["description"] as! String
            
        let taskName : String = taskInfo["name"] as! String
        
            self.task = Task(desc: taskDescription, status: taskStatus, type: Int(taskType), name: taskName)
        }
    }

}
