//
//  UsageAnnotationView.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 29/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit
import MapKit

class UsageAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        super.init()
    }

}
