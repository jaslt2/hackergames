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
    
    var selectedDisability: String?
    var user : FIRUser!
    var disabilityType: String?
    var types = ["Autism", "Blindness", "Deafness", "ADHD"]

    @IBAction func buttonPressed(_ sender: Any) {
        print("Submitting user profile")
        self.updateUser(description: self.userDescription.text, disability: self.selectedDisability!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.disabilityPicker.delegate = self
        self.disabilityPicker.dataSource = self
        
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
    
    func updateUser(description: String, disability: String){
        //TODO Hardcoding this!!
        var userId = "MfB4sE4fuEY0pkiF5gkThB8mtum1";
        FIRDatabase.database().reference().child("users/" + userId + "/description").setValue(description)
        FIRDatabase.database().reference().child("users/" + userId + "/disability").setValue(disability)
    }
}

