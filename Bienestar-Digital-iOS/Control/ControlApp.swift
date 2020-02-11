//
//  ControlApp.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 11/02/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit

//Structs para usar en los servicios de control de tiempo de las apps
struct ControlAppConsulta: Codable {
    let user_id: Int
    let app_name: String
}
struct ControlAppConsultaResponse: Codable {
    let max_time: Int
}

struct ControlAppActualizacion: Codable {
    let user_id: Int
    let app_name: String
    let max_time: Int
}
