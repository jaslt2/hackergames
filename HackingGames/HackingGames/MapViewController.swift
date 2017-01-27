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
    
    @IBOutlet weak var userDetailView : DetailUserMapView!
    var userHelpView : UserHelpView?
    
    @IBOutlet weak var mapActionButton: UIButton!
    @IBOutlet weak var listActionButton: UIButton!

    let pinSegue : String = "MapToPinSegue"
    
    private var user : FIRUser? = nil
    
    var userSelected : User?
    
    
    @IBOutlet weak var mapView: MKMapView!

    
    @IBAction func goToPinButtonClicked(_ sender: UIButton) {
         self.performSegue(withIdentifier: pinSegue, sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.listUser = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      
        self.userDetailView.isHidden = true
        self.userDetailView.delegate = self
        
        configureTabbarIcons()
        
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
    
    
    func configureTabbarIcons()
    {
        self.tabBarController!.tabBar.items![0].image = UIImage(named: "mapTab")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.tabBarController!.tabBar.items![0].selectedImage = UIImage(named: "mapTabSelected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.tabBarController!.tabBar.items![1].image = UIImage(named: "helpMeTab")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.tabBarController!.tabBar.items![1].selectedImage = UIImage(named: "helpMeTabSelected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
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
            annontation.user = user
            
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

extension MapViewController : MKMapViewDelegate,UserMapProtocol
{
    func userWantInformation(user: User) {
        self.performSegue(withIdentifier: pinSegue, sender: self)
    }
    
    func userHasRequestedHelp(user: User) {
        
        self.userDetailView.isHidden = true
        
        self.userHelpView = UserHelpView(frame:  CGRect(x: 0, y: 0, width: self.view.frame.width - 50, height: self.view.frame.height / 1.8))
        self.userHelpView?.center = self.view.center
        
        self.userHelpView?.user = user
        
        self.view.addSubview(self.userHelpView!)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        UIView.animate(withDuration: 1.0) {
            self.userDetailView.isHidden = true
            self.userHelpView?.isHidden = true
        }
    }
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
        
        if (view.annotation is MKUserLocation) {
            return
        }
        let annotation : ProfileMKPointAnnotation = view.annotation as! ProfileMKPointAnnotation
        
        self.userSelected = annotation.user
        
        self.userDetailView.user = self.userSelected
        
        self.userDetailView.updateInformation()
        
        UIView.animate(withDuration: 1.0) { 
            self.userDetailView.isHidden = false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == pinSegue)
        {
            let controller : MapPinViewController = segue.destination as! MapPinViewController

            controller.userToAssist = self.userSelected
            
        }
    }

}
