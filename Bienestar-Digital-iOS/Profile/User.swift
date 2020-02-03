//
//  User.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 03/02/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//
/**
 {
     "id": 5,
     "name": "Ruperto",
     "email": "ruperto@gmail.com",
     "role_id": 2,
     "created_at": "2020-02-03 13:01:48",
     "updated_at": "2020-02-03 13:01:48"
 }
 */

import UIKit

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let role_id: Int
    let created_at: String
    let updated_at: String
}
