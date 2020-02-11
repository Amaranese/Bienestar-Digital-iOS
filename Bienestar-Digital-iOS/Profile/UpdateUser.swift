//
//  UpdateUser.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 10/02/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit
//struct para el servicio http://localhost:8888/Bienestar/public/index.php/api/user/\(userID)
struct UpdateUser: Codable {
    let email: String?
    let name: String?
    let oldPassword: String?
    let newPassword: String?
    let confirmNewPassword: String?
}
