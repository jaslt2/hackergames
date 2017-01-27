//
//  MapViewController.swift
//  HackingGames
//
//  Created by MOHAMED ARRADI-ALAOUI on 26/01/2017.
//  Copyright © 2017 HackerGames. All rights reserved.
//

import Foundation
import MapKit
import Firebase

class MapViewController: UIViewController {
    
    private let disabilitySegue : String = "SignInToDisabilityFilterSegue"
    

    private let pinSegue : String = "MapToPinSegue"
    
    private var user : FIRUser? = nil

    private var listUser : [FIRUser]? = nil
    
    @IBOutlet weak var mapView: MKMapView!

    
    @IBAction func goToPinButtonClicked(_ sender: UIButton) {
        print("button clicked")
         self.performSegue(withIdentifier: pinSegue, sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.listUser = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        signInTheUserIfRequired()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FirebaseManager.sharedInstance.getUsers { (listUser : [User]) in
            
        }

    }
    
    func signInTheUserIfRequired()
    {
        if !UserManager.sharedInstance.userIsLogged() {
            self.performSegue(withIdentifier: disabilitySegue, sender: self)
        }
    }
}

extension MapViewController : MKMapViewDelegate
{
    func mapView(_ viewFormapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.image = UIImage(named:"xaxas")
            anView?.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView?.annotation = annotation
        }
        
        return anView
    }
}
