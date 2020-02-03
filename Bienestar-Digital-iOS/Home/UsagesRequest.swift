//
//  UsagesRequest.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 26/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//
import UIKit
class UsagesRequest: Codable {
    let user_id: Int
    init(user_id: Int) {
        self.user_id = user_id
    }
}
