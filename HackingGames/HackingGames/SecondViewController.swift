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

protocol ProfileSetupProtocol {
    func profileWasSetup()
}

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var delegate : ProfileSetupProtocol?
    
    var user : FIRUser!
    var currentUser : User? = nil
    var selectedDisability: String?
    var disabilityType: String?
    let types = ["Autism", "Blindness", "Deafness", "ADHD"]
    
    
    @IBOutlet weak var userDescription: UITextView!
    @IBOutlet weak var disabilityPicker: UIPickerView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.user = UserManager.sharedInstance.getFirebaseUser()
        FirebaseManager.sharedInstance.getUserById(userId: user.uid, completion: { (user: User) -> Void in
            self.currentUser =  user
            self.phoneNumber.text = self.currentUser?.phoneNumber;
            if self.currentUser?.description != nil{
                self.userDescription.text = self.currentUser?.description
            }
            if self.currentUser?.disability != nil{
                self.disabilityPicker.selectRow(self.findIndexOfDisability(type: (self.currentUser?.disability)!), inComponent: 0, animated: true)
            } else {
                self.disabilityPicker.selectRow(0, inComponent: 0, animated: true)
            }
        })
        
        self.disabilityPicker.delegate = self
        self.disabilityPicker.dataSource = self
        self.displayName.text = self.user.displayName
        self.email.text = self.user.email
        
        if let url = NSURL(string: (self.user.photoURL?.absoluteString)!) {
            if let data = NSData(contentsOf: url as URL) {
                self.photo.image = UIImage(data: data as Data)
                self.photo.layer.cornerRadius = self.photo.frame.size.width / 2;
            }        
        }
    }
    
    func findIndexOfDisability(type: String) -> Int {
        if let index = types.index(of: type) {
            print("Found disability at index \(index)")
            return index
        } else{
            return 0
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
        self.selectedDisability = self.types[row]
        print("Set selected disability to ", self.selectedDisability!)
    }
    
    func pickerView(_ reusingpickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        let data = self.types[row]
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightRegular)])
        label?.attributedText = title
        label?.textAlignment = .center
        return label!
        
    }
    
   func updateUser(description: String, disability: String){
        FIRDatabase.database().reference().child("users/" + self.user.uid + "/description").setValue(description)
        FIRDatabase.database().reference().child("users/" + self.user.uid + "/disability").setValue(disability)
    
        self.dismiss(animated: true) {
            self.delegate?.profileWasSetup()
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        if let disability : String = self.selectedDisability
        {
            self.updateUser(description: self.userDescription.text, disability: disability)
        }
    }
    
}

