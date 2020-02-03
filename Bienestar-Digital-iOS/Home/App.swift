//
//  App.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 11/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//
import UIKit
class App {
    let identifier: Int
    let name: String
    let image: UIImage
    init(identifier: Int, name: String, image: UIImage) {
        self.identifier = identifier
        self.name = name
        self.image = image
    }
}
