//
//  Task.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation


enum Status : String
{
     case Open = "OPEN",
     Declined = "CLOSED",
     Cancelled = "CANCELED"
}

enum TaskType : Int
{
    case Urgent = 1, General
}


struct Task
{
        private (set) var description : String?
        private (set) var name : String?
        private (set) var status : Status?
        private (set) var type : TaskType?
    
    init(desc : String, status : String, type : Int, name : String)
    {
       self.description = desc
       self.status = Status(rawValue: status)
       self.type = TaskType(rawValue: type)
       self.name = name
    }
    
}
