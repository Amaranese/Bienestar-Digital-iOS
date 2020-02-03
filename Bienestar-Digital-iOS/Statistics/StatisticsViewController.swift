//
//  StatisticsViewController.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 29/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit
enum Rango: Int {
    case diario = 1
    case semanal = 7
    case mensual = 31
}
class StatisticsViewController: UIViewController {
    @IBOutlet weak var lbTiempos: UILabel!
    @IBOutlet weak var selector: UIPickerView!
    var usages: [UsageApps]! = nil
    let pickerData = ["Diario", "Semanal", "Mensual"]
    var apps = [String: [UsageApps]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selector.delegate = self
        self.selector.dataSource = self
        
        //se bucan los nombres de todas las apps
        var appsNames: [String] = []
        for usage in usages {
            if !appsNames.contains(usage.app) {
                appsNames.append(usage.app)
            }
        }
        //Se busca los UsageApps de todas las apps y se agrupan
        for appName in appsNames {
            apps[appName] = usages.filter { $0.app == appName }
        }
        updateTiempos(apps, rango: .diario)
    }
    func updateTiempos(_ apps: [String: [UsageApps]], rango: Rango) {
        var texto = ""
        var tiempos = [String: Double]()
        for (key,value) in apps {
            tiempos[key] = Utils.calculateTimeInSeconds(usages: value)
            let media = Int(tiempos[key]!) / rango.rawValue
            texto = texto + "\(key): \(media) segundos\n"
        }
        lbTiempos.text = texto
    }
}
extension StatisticsViewController: UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            updateTiempos(apps, rango: .diario)
        } else if(row == 1) {
            updateTiempos(apps, rango: .semanal)
        } else if(row == 2) {
            updateTiempos(apps, rango: .mensual)
        }
    }
}
extension StatisticsViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerData[row]
    }
}
