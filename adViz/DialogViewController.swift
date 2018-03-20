//
//  DialogViewController.swift
//  adViz
//
//  Created by Russell Nibbelink on 12/7/15.
//  Copyright © 2015 adViz. All rights reserved.
//
import UIKit
import GoogleMaps


class DialogViewController: UIViewController {
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRectMake(0, 65.0, 350.0, 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        self.view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true
    }
    
}

// Handle the user's selection.
extension DialogViewController: GMSAutocompleteResultsViewControllerDelegate {
    //func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!) {
    //public func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!)
    
    //public func resultsController(resultsController: GMSAutocompleteResultsViewController!, didFailAutocompleteWithError error: NSError!)
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!){

            searchController?.active = false
            // Do something with the selected place.
            print("Place name: ", place.name)
            print("Place address: ", place.formattedAddress)
            print("Place attributions: ", place.attributions)
    }
    
    //func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithError error: NSError!){
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didFailAutocompleteWithError error: NSError!) {
        // TODO: handle the error.
            print("Error: ", error.description)
    }
}





/*
import UIKit
import GoogleMaps

class DialogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Present the Autocomplete view controller when the button is pressed.
    @IBAction func autocompleteClicked(sender: AnyObject) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.presentViewController(autocompleteController, animated: true, completion: nil)
    }
}

extension DialogViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController!, didAutocompleteWithPlace place: GMSPlace!) {
        print("Place name: ", place.name)
        print("Place coordinates: ", place.coordinate)
        print("Place address: ", place.formattedAddress)
        print("Place attributions: ", place.attributions)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewController(viewController: GMSAutocompleteViewController!, didFailAutocompleteWithError error: NSError!) {
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
    // User canceled the operation.
    func wasCancelled(dialogViewController: GMSAutocompleteViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
*/
/*
public func viewController(viewController: GMSAutocompleteViewController!, didAutocompleteWithPlace place: GMSPlace!)

/**
* Called when a non-retryable error occurred when retrieving autocomplete predictions or place
* details. A non-retryable error is defined as one that is unlikely to be fixed by immediately
* retrying the operation.
* <p>
* Only the following values of |GMSPlacesErrorCode| are retryable:
* <ul>
* <li>kGMSPlacesNetworkError
* <li>kGMSPlacesServerError
* <li>kGMSPlacesInternalError
* </ul>
* All other error codes are non-retryable.
* @param viewController The |GMSAutocompleteViewController| that generated the event.
* @param error The |NSError| that was returned.
*/
public func viewController(viewController: GMSAutocompleteViewController!, didFailAutocompleteWithError error: NSError!)

/**
* Called when the user taps the Cancel button in a |GMSAutocompleteViewController|.
* @param viewController The |GMSAutocompleteViewController| that generated the event.
*/
public func wasCancelled(viewController: GMSAutocompleteViewController!)


*/

/*import UIKit
import GoogleMaps

class DialogViewController: UIViewController {

    var placesClient: GMSPlacesClient?
    
    // Instantiate a pair of UILabels in Interface Builder
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placesClient = GMSPlacesClient()
    }
    
    // Add a UIButton in Interface Builder to call this function
    @IBAction func getCurrentPlace(sender: UIButton) {
        
        placesClient?.currentPlaceWithCallback({
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No current place"
            self.addressLabel.text = ""
            
            if let placeLicklihoodList = placeLikelihoodList {
                let place = placeLicklihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress.componentsSeparatedByString(", ")
                        .joinWithSeparator("\n")
                }
            }
        })
    }
} */
