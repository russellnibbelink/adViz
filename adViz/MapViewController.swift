//
//  MapViewController.swift
//  adViz
//
//  Created by Russell Nibbelink on 12/7/15.
//  Copyright © 2015 adViz. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var storedMapView: GMSMapView?
    var defaultView: UIView?
    var placesClient: GMSPlacesClient?
    var currentLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //getting the current location
        placesClient = GMSPlacesClient()
        
        placesClient?.currentPlaceWithCallback({
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLicklihoodList = placeLikelihoodList {
                let place = placeLicklihoodList.likelihoods.first?.place
                if let place = place {
                    print("current location")
                    self.currentLocation = place.coordinate
                    //print(place.name)
                    //print(place.coordinate)
                    //print(place.formattedAddress.componentsSeparatedByString(", ").joinWithSeparator("\n"))
                    print(self.currentLocation)
                }
            }
        })

        
        //let camera = GMSCameraPosition.cameraWithLatitude(-33.86, longitude: 151.20, zoom: 6)
        //let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        let mapView = GMSMapView(frame: CGRectZero) //frame: self.view.bounds
        let vizag = GMSCameraPosition.cameraWithLatitude(17.7107022,
            longitude: 83.315889, zoom: 12)
        mapView.camera = vizag
        mapView.myLocationEnabled = true
        mapView.delegate = self
        //print(self.view)
        defaultView = self.view
        storedMapView = mapView
        self.view = mapView
        //print(self.view)
        
        mapView.indoorEnabled = false
        mapView.myLocationEnabled = true
        if let mylocation = mapView.myLocation {
            //let target = CLLocationCoordinate2DMake(-33.868, 151.208)
            //mapView.camera = GMSCameraPosition.cameraWithTarget(target, zoom:6)
            mapView.settings.myLocationButton = true
            mapView.animateToLocation(mapView.myLocation.coordinate)
            print("User's location: \(mylocation)")
        } else {
            print("User's location is unknown")
        }
        
        /*
        //automatically fits zoom between two locations, useful for when calculating routes
        let vancouver = CLLocationCoordinate2DMake(49.26, -123.11)
        let calgary = CLLocationCoordinate2DMake(51.05, -114.05)
        let bounds = GMSCoordinateBounds(coordinate: vancouver, coordinate: calgary)
        let camera = mapView.cameraForBounds(bounds, insets:UIEdgeInsetsZero)
        mapView.camera = camera;
        */
        
        let mapInsets = UIEdgeInsetsMake(60.0, 0.0, 60.0, 0.0)
        mapView.padding = mapInsets
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        let path = GMSMutablePath()
        path.addCoordinate(CLLocationCoordinate2DMake(-33.85, 151.20))
        path.addCoordinate(CLLocationCoordinate2DMake(-33.70, 151.40))
        path.addCoordinate(CLLocationCoordinate2DMake(-33.73, 151.41))
        let polyline = GMSPolyline(path: path)
        //polyline.strokeWidth = 1.0
        //polyline.strokeColor = UIColor.blackColor()
        polyline.map = mapView
        
        let rect = GMSMutablePath()
        rect.addCoordinate(CLLocationCoordinate2DMake(-33.2, 151.00))
        rect.addCoordinate(CLLocationCoordinate2DMake(-33.5, 151.00))
        rect.addCoordinate(CLLocationCoordinate2DMake(-33.5, 151.80))
        rect.addCoordinate(CLLocationCoordinate2DMake(-33.2, 151.80))
        
        // Create the polygon, and assign it to the map.
        let polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor(red:0.25, green:0, blue:0, alpha:0.5)
        polygon.strokeColor = UIColor.blackColor()
        polygon.strokeWidth = 2
        polygon.map = mapView
        
        let circleCenter = CLLocationCoordinate2DMake(-33.9, 150.0)
        let circ = GMSCircle(position: circleCenter, radius: 10000)
        circ.fillColor = UIColor(red:0.25, green:0, blue:0, alpha:0.5)
        circ.map = mapView;
        
        
        
        let crimes = [[17.70491, 83.30465],
            [17.70647, 83.30117],
            [17.706, 83.30838],
            [17.7431, 83.3388],
            [17.706, 83.30385],
            [17.76106, 83.21578],
            [17.81185, 83.36595],
            [17.7146, 83.29423],
            [17.75722, 83.21527],
            [17.70694, 83.20361],
            [17.5375, 83.25361],
            [17.91527, 83.54888],
            [17.74441, 83.30891],
            [17.72024, 83.28601],
            [17.73403, 83.31743],
            [17.74196, 83.26129],
            [17.76565, 83.35727],
            [17.72709, 83.33741],
            [17.73553, 83.28917],
            [17.75116, 83.24866],
            [17.70557, 83.08488],
            [17.8155, 83.20506],
            [17.73344, 83.32081],
            [17.73981, 83.30773],
            [17.73402, 83.30559],
            [17.68991, 83.22684],
            [17.7835, 83.19947],
            [17.80934, 83.20878],
            [17.78258, 83.21315],
            [17.74329, 83.31305],
            [17.76213, 83.22064],
            [17.69146, 83.13584],
            [17.56995, 83.09056],
            [17.7969, 83.20803],
            [17.75694, 83.35416],
            [17.54027, 83.20972],
            [17.74875, 83.24628],
            [17.72581, 83.31132],
            [17.72923, 83.34342],
            [17.73564, 83.27639],
            [17.7774, 83.21503],
            [17.82153, 83.35103],
            [17.68486, 83.23296],
            [17.91827, 83.42489],
            [17.7285, 83.29874],
            [17.93169, 83.40153],
            [17.7629, 83.33853],
            [17.68682, 83.14227],
            [17.77773, 83.22409],
            [17.76249, 83.33142],
            [17.73981, 83.30004],
            [17.68451, 83.1372],
            [17.82087, 83.21038],
            [17.70711, 83.30731],
            [17.68683, 83.16837],
            [17.9225, 83.41463],
            [17.80726, 83.34006],
            [17.82022, 83.36197],
            [17.79879, 83.36736],
            [17.75409, 83.3454],
            [17.72796, 83.30494],
            [17.6893, 83.20504],
            [17.53765, 83.08531],
            [17.78296, 83.3584],
            [17.8197, 83.35691],
            [17.79884, 83.21494],
            [17.70055, 83.17967],
            [17.72768, 83.29372],
            [17.69217, 83.19077],
            [17.69147, 83.17264],
            [17.73737, 83.22617],
            [17.81225, 83.37426],
            [17.73339, 83.27648],
            [17.73737, 83.22617],
            [17.89568, 83.38029],
            [17.80685, 83.35956],
            [17.70477, 83.30589],
            [17.7818, 83.35868],
            [17.73864, 83.29992],
            [17.71105, 83.30027],
            [17.73024, 83.30373],
            [17.74678, 83.24705],
            [17.73449, 83.31261],
            [17.71645, 83.30493],
            [17.73532, 83.26715],
            [17.7373, 83.29987],
            [17.746, 83.26404],
            [17.90568, 83.39952],
            [17.72752, 83.30913],
            [17.68557, 83.24429],
            [17.9068, 83.38415],
            [17.70498, 83.29429],
            [17.70647, 83.30791],
            [17.72754, 83.29849],
            [17.81165, 83.35297],
            [17.73483, 83.30103],
            [17.82138, 83.20547],
            [17.8159, 83.34045],
            [17.53801, 83.08635],
            [17.67736, 83.1906],
            [17.72094, 83.33156],
            [17.81167, 83.35834],
            [17.72094, 83.33156],
            [17.73517, 83.27793],
            [17.68458, 83.212],
            [17.71601, 83.30673],
            [17.72742, 83.33781],
            [17.75971, 83.32126],
            [17.73096, 83.29893],
            [17.73654, 83.31012],
            [17.74562, 83.21469],
            [17.73851, 83.21902],
            [17.7177, 83.31901],
            [17.68701, 83.21873],
            [17.81061, 83.35881],
            [17.69244, 83.16777],
            [17.90018, 83.37422],
            [17.71001, 83.29471],
            [17.89381, 83.4476],
            [17.74049, 83.21755],
            [17.80887, 83.19953],
            [17.9049, 83.43704],
            [17.74409, 83.23113],
            [17.6821, 83.14285],
            [17.74715, 83.22314],
            [17.68461, 83.21637],
            [17.7089, 83.29659],
            [17.74053, 83.31701],
            [17.74038, 83.31739],
            [17.7143, 83.30093],
            [17.72057, 83.30085],
            [17.73947, 83.31514],
            [17.71694, 83.1956],
            [17.74286, 83.3088],
            [17.74196, 83.27101],
            [17.72144, 83.3176],
            [17.80083, 83.22262],
            [17.68786, 83.21217],
            [17.68629, 83.18302],
            [17.68605, 83.18252],
            [17.68871, 83.23413],
            [17.68046, 83.18941],
            [17.89038, 83.45145],
            [17.931, 83.42619],
            [17.74541, 83.33587],
            [17.80457, 83.35971],
            [17.69228, 83.15407],
            [17.68509, 83.18409],
            [17.76426, 83.31839],
            [17.761, 83.30934],
            [17.74278, 83.30595],
            [17.76725, 83.3214],
            [17.77753, 83.22707],
            [17.76723, 83.32245],
            [17.74028, 83.26614],
            [17.78784, 83.19417],
            [17.82632, 83.24942],
            [17.68596, 83.13625],
            [17.76611, 83.32204],
            [17.74603, 83.32054],
            [17.82123, 83.35575],
            [17.80584, 83.35905],
            [17.74646, 83.32018],
            [17.74366, 83.28391],
            [17.68495, 83.13707],
            [17.74214, 83.25064],
            [17.76611, 83.32204],
            [17.75446, 83.33597],
            [17.79737, 83.21611],
            [17.68468, 83.13291],
            [17.71709, 83.32008],
            [17.76759, 83.31763],
            [17.73495, 83.28882],
            [17.73503, 83.28955],
            [17.68806, 83.1345],
            [17.73397, 83.27639],
            [17.73363, 83.33875],
            [17.69175, 83.15457],
            [17.68789, 83.23356],
            [17.75571, 83.22001],
            [17.79788, 83.21059],
            [17.75058, 83.34877],
            [17.72069, 83.33535],
            [17.74397, 83.33287],
            [17.81528, 83.34255],
            [17.76546, 83.32708],
            [17.74117, 83.27135],
            [17.68742, 83.16446],
            [17.7173, 83.30601],
            [17.72552, 83.30658],
            [17.682, 83.20131]]
        
        for coord in crimes {
                let outCircle = CLLocationCoordinate2DMake(coord[0], coord[1]);
                let oCirc = GMSCircle(position: outCircle, radius: 200)
                oCirc.fillColor = UIColor(red:1, green:0.25, blue:0, alpha:0.25)
                oCirc.strokeWidth = 0
                oCirc.map = mapView;
                
                let inCircle = CLLocationCoordinate2DMake(coord[0], coord[1]);
                let iCirc = GMSCircle(position: inCircle, radius: 65)
                iCirc.fillColor = UIColor(red:1, green:0, blue:0, alpha:0.75)
                iCirc.strokeWidth = 0
                iCirc.map = mapView;
        }
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 607, 250, 60)
        button.backgroundColor = UIColor.redColor()
        button.setTitle("Panic Button", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel!.font =  UIFont(name: "Futura", size: 36)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
        
        let report   = UIButton(type: UIButtonType.System) as UIButton
        report.frame = CGRectMake(250, 607, 125, 60)
        report.backgroundColor = UIColor.whiteColor()
        report.setTitle("Guard", forState: UIControlState.Normal)
        report.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        report.titleLabel!.font =  UIFont(name: "Futura", size: 36)
        report.addTarget(self, action: "reportAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(report)

        
        let dest   = UIButton(type: UIButtonType.System) as UIButton
        dest.frame = CGRectMake(0, 20, 375, 30)
        dest.backgroundColor = UIColor.grayColor()
        dest.alpha = 0.75
        dest.setTitle("Set Destination", forState: UIControlState.Normal)
        dest.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        dest.titleLabel!.font =  UIFont(name: "Futura", size: 20)
        dest.addTarget(self, action: "destAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(dest)

    }
    func launchSearch(){
        self.view = defaultView
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRectMake(0, 20, 375.0, 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        self.view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true

    }
    
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    func buttonAction(sender:UIButton!)
    {
        print("Button tapped")
        sender.setTitle("Help Incoming", forState: UIControlState.Normal)
        sender.backgroundColor = UIColor.greenColor()
        

    }
    
    func reportAction(sender:UIButton!)
    {
        print("Report tapped")
        
    }
    
    func destAction(sender:UIButton!)
    {
        print("Dest tapped")
        sender.setTitle("Change Destination", forState: UIControlState.Normal)
        
        placesClient?.currentPlaceWithCallback({
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLicklihoodList = placeLikelihoodList {
                let place = placeLicklihoodList.likelihoods.first?.place
                if let place = place {
                    print("checkpoint 2")
                    print(place.name)
                    print(place.coordinate)
                    print(place.formattedAddress.componentsSeparatedByString(", ").joinWithSeparator("\n"))
                }
            }
        })

        
        launchSearch()
    }
}

extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
    //func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!) {
    //public func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!)
    
    //public func resultsController(resultsController: GMSAutocompleteResultsViewController!, didFailAutocompleteWithError error: NSError!)
    
    
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!){
        
        searchController?.active = false
        // Do something with the selected place.
        print("Checkpoint 1")
        let destination = place.coordinate
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress)
        print("Place attributions: ", place.attributions)
        
        self.currentLocation = CLLocationCoordinate2DMake(17.7107022, 83.315889)
        
        let bounds = GMSCoordinateBounds(coordinate: self.currentLocation!, coordinate: destination)
        let camera = storedMapView!.cameraForBounds(bounds, insets:UIEdgeInsetsMake(25, 25, 25, 25))
        storedMapView!.camera = camera;
        
        let startmarker = GMSMarker()
        startmarker.position = self.currentLocation!
        startmarker.title = "Current Location"
        startmarker.snippet = "Starting Point"
        startmarker.map = storedMapView!
        
        let endmarker = GMSMarker()
        endmarker.position = destination
        endmarker.title = "Destination"
        endmarker.snippet = "End Point"
        endmarker.map = storedMapView!
        
        print("STARTING REQUEST")
        let req = "https://maps.googleapis.com/maps/api/directions/json"
        let key = "AIzaSyBKyBHg1iGzqbkg78EHAmFR8kGx6sq8ci4"
        let orig_lat = String(self.currentLocation.latitude)
        let orig_long = String(self.currentLocation.longitude)
        let dest_lat = String(destination.latitude)
        let dest_long = String(destination.longitude)
        let params = [
            "origin": String(orig_lat + " " + orig_long),
            "destination": String(dest_lat + " " + dest_long),
            "mode": "driving",
            "key": key
        ]

        Alamofire.request(.GET, req, parameters: params)
            .responseJSON { response in
                //print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    print("parsing JSON")
                    if let routes = JSON["routes"]{
                        print("routes")
                        //print(routes)
                        if let legs = routes![0]["legs"]{
                            print("legs")
                            //print(legs)
                            if let steps = legs![0]["steps"]{
                                print("Steps")
                                //print(steps!)
                                //print(steps! as? NSDictionary)
                                //print(steps! as? NSArray)
                                print("next")
                                //print(steps![0])
                                let path = GMSMutablePath()
                                for step in (steps! as? NSArray)!{
                                    print("step1")
                                    //print(step)
                                    if let end = step["end_location"]{
                                        if let lat = end!["lat"] {
                                            if let lon = end!["lng"] {
                                                print(lat)
                                                print(lon)
                                                //print(NSInteger((lat as? String)!))
                                                //print(NSInteger((lon as? String)!))
                                                path.addCoordinate(CLLocationCoordinate2DMake((lat! as? CLLocationDegrees)! , (lon! as? CLLocationDegrees)!))
                                            }
                                        }
                                    }
                                    
                                //(17.714419, 83.316257)
                                //(17.723277, 83.325849)
                                    
                                    //(17.727978, 83.313832)

                                    
                                    
                                }
                                
                                //polyline.strokeColor = UIColor.blackColor()

                                let polyline = GMSPolyline(path: path)
                                polyline.strokeWidth = 3.0
                                polyline.map = self.storedMapView
                                
                            }
                        }
                    }
                }
        }
        
       
        
        
        self.view = storedMapView
        
        /*
        //automatically fits zoom between two locations, useful for when calculating routes
        let vancouver = CLLocationCoordinate2DMake(49.26, -123.11)
        let calgary = CLLocationCoordinate2DMake(51.05, -114.05)
        let bounds = GMSCoordinateBounds(coordinate: vancouver, coordinate: calgary)
        let camera = mapView.cameraForBounds(bounds, insets:UIEdgeInsetsZero)
        mapView.camera = camera;
        */

    }
    
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didFailAutocompleteWithError error: NSError!) {
        // TODO: handle the error.
        print("Cancelled")
        print("Error: ", error.description)
    }
    
    func wasCancelled(viewController: GMSAutocompleteViewController!) {
        print("Autocomplete was cancelled.")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
