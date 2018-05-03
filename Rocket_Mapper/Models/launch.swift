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

class Launch:  MKPointAnnotation{
    private var site: String = ""
    private var windowStart: String = ""
    private var windowEnd: String = ""
    
    init(coordinate: CLLocationCoordinate2D, site: String, windowStart: String, windowEnd: String) {
        super.init()

        self.coordinate = coordinate
        self.site = site
        self.windowStart = windowStart
        self.windowEnd = windowEnd
    }
}
