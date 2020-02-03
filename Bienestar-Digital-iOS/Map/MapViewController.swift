//
//  MapViewController.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 29/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//
import UIKit
import MapKit
class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var usages: [UsageApps]! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        for usage in usages {
            let annotation = UsageAnnotation(title: usage.app, subtitle: usage.event, coordinate: CLLocationCoordinate2DMake(usage.latitude, usage.longitude))
            mapView.addAnnotation(annotation)
            print("lat lang: \(usage.latitude), \(usage.longitude)")
        }
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
