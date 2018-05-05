//
//  launch.swift
//  Rocket_Mapper
//
//  Created by Ian Rigg on 4/29/18.
//  Copyright © 2018 Ian Rigg. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import SwiftyJSON

class Launch:  MKPointAnnotation {
    
    var response: JSON = JSON()
    
    init(coordinate: CLLocationCoordinate2D, response: JSON) {
        super.init()

        self.coordinate = coordinate
        self.response = response
    }
}
