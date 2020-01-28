//
//  Utils.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 26/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit
class Utils {
    class func loadImage(appName: String) -> UIImage {
        var image: UIImage
        switch appName {
            case "Reloj": image = UIImage(named: "clock")!
            case "Instagram": image = UIImage(named: "instagram")!
            case "Whatsapp": image = UIImage(named: "whatsapp")!
            case "Facebook": image = UIImage(named: "facebook")!
            case "Gmail": image = UIImage(named: "gmail")!
            case "Chrome": image = UIImage(named: "chrome")!
            default: image = UIImage(named: "clock")!
        }
        return image
    }
}
