//
//  Usage.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 21/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//
import UIKit
//Date,App,Event,Latitude,Longitude
//Class que permite definir el tipo Usage para los datos del servidor(los que se cargarons desde el excel la primera vez)
class Usage: Codable {
    let date: String
    let app: String
    let event: String
    let latitude: Double
    let longitude: Double
    init(line: String) {
        let fields = line.split(separator: ",")
        self.date = String(fields[0])
        self.app = String(fields[1])
        self.event = String(fields[2])
        self.latitude = Double(fields[3])!
        self.longitude = Double(fields[4])!
    }
}
class UsageApps: Codable {
    let id: Int
    let date: String
    let app: String
    let event: String
    let latitude: Double
    let longitude: Double
}
