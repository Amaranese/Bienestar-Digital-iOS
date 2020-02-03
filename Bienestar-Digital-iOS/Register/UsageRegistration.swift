//
//  UsageRegistration.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 21/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//
import UIKit
/*
{
    "user_id": 2,
    "usages":[
        {
            "app":"instagram",
            "date": "2019-11-12 08:00:00",
            "event":"closes",
            "latitude":40.437545,
            "longitude":-3.692569
        }
    ]
}
**/
struct UsageRegistration: Codable {
    let user_id: Int
    let usages: [Usage]
}
