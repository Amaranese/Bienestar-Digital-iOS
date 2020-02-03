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
    class func calculateTimeInSeconds(usages: [UsageApps]) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var openDate: Date!
        var totalUsage: Double = 0
        for i in 0...usages.count-1 {
            if i%2 == 0 { //open
                openDate = dateFormatter.date(from: usages[i].date)!
            } else { // close
                let closeDate = dateFormatter.date(from: usages[i].date)!
                let seconds = openDate.distance(to: closeDate)
                totalUsage = totalUsage + seconds
            }
        }
        return totalUsage
    }
    class func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    class func validateEmptyFields(fields: [String]) -> Bool {
        for field in fields {
            if field.isEmpty {
                return false
            }
        }
        return true
    }
}
