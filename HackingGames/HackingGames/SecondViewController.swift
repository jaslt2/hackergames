//
//  SecondViewController.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var userDescription: UITextView!
    @IBOutlet weak var disabilityPicker: UIPickerView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    var user : FIRUser!
    var currentUser : User? = nil
    var selectedDisability: String?
    var disabilityType: String?
    var types = ["Autism", "Blindness", "Deafness", "ADHD"]

    @IBOutlet weak var email: UILabel!
    @IBAction func buttonPressed(_ sender: Any) {
        print("Submitting user profile")
        //self.updateUser(description: self.userDescription.text, disability: self.selectedDisability!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.user = UserManager.sharedInstance.getFirebaseUser()
        FirebaseManager.sharedInstance.getUserById(userId: user.uid, completion: { (user: User) -> Void in
            self.currentUser =  user
            self.phoneNumber.text = self.currentUser?.phoneNumber;
        })
        
        self.disabilityPicker.delegate = self
        self.disabilityPicker.dataSource = self
        self.displayName.text = user.displayName
        self.email.text = user.email
        
        if let url = NSURL(string: (user.photoURL?.absoluteString)!) {
            if let data = NSData(contentsOf: url as URL) {
                self.photo.image = UIImage(data: data as Data)
            }        
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.selectedDisability = self.types[row]
        return self.types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
   /** func updateUser(description: String, disability: String){
        
        FIRDatabase.database().reference().child("users/" + self.user + "/description").setValue(description)
        FIRDatabase.database().reference().child("users/" + self.user + "/disability").setValue(disability)
    }**/
}

