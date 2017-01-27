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
    
    let disabilitySegue : String = "SignInToDisabilityFilterSegue"
    
    private var listUser : [User]? = nil
    private var annotations : NSMutableArray?
    
    @IBOutlet weak var mapActionButton: UIButton!
    @IBOutlet weak var listActionButton: UIButton!

    private let pinSegue : String = "MapToPinSegue"
    
    private var user : FIRUser? = nil
    
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
        
        self.mapActionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.listActionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        
        LocationService.sharedInstance().addObserver(self, forKeyPath: "currentLocation", options: NSKeyValueObservingOptions.new, context: nil)
        
        LocationService.sharedInstance().startUpdatingLocation()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        FirebaseManager.sharedInstance.getUsers { (listUser : [User]) in
            DispatchQueue.main.async {
                self.listUser = listUser
                self.addMapAnnotations()
            }
        }
        signInTheUserIfRequired()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == "currentLocation")
        {
            goToUserLocation()
        }
    }
    
    //MARK : - Map Actions
    
    func addMapAnnotations()
    {
        self.annotations = NSMutableArray()
        
        for user in self.listUser!
        {
            let annontation : ProfileMKPointAnnotation = ProfileMKPointAnnotation()
            
            annontation.coordinate = CLLocationCoordinate2D(latitude: user.location.coordinate.latitude, longitude: user.location.coordinate.longitude)
           
            annontation.title = user.name
            
            if (!(user.photoUrl?.isEmpty)!)
            {
                annontation.photoUrl = user.photoUrl!
            }
            self.annotations?.add(annontation)
        }
        self.mapView.addAnnotations(self.annotations! as NSArray as! [MKAnnotation])
    
    }
    
    func goToUserLocation()
    {
        let spanX : Float =  0.01000
        let spanY : Float =  0.01000
        
        var region : MKCoordinateRegion = MKCoordinateRegion()
        
        region.center.latitude = (LocationService.sharedInstance().locationManager.location?.coordinate.latitude)!
        region.center.longitude = (LocationService.sharedInstance().locationManager.location?.coordinate.longitude)!
        
        region.span.latitudeDelta = CLLocationDegrees(spanX)
        region.span.longitudeDelta = CLLocationDegrees(spanY)
        
        self.mapView.setRegion(region, animated: true)
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
            return nil
        }
        
        let reuseId = "UserPins"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
       
        if anView == nil {
            
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.image = UIImage(named:"pin")
            anView?.canShowCallout = false
        }
        else {
            anView?.annotation = annotation
        }
        
        return anView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }

}
