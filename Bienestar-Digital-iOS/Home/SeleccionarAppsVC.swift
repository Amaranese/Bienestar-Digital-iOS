//
//  SeleccionarAppsVC.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 11/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit

class SeleccionarAppsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var apps: [Usage] = []
//    var apps = [
//        App(nombre: "Whatsapp", image: UIImage(named: "whatsapp")!),
//        App(nombre: "Instagram", image: UIImage(named: "instagram")!),
//        App(nombre: "Clock", image: UIImage(named: "clock")!),
//        App(nombre: "Facebook", image: UIImage(named: "facebook")!),
//        App(nombre: "Gmail", image: UIImage(named: "gmail")!),
//        App(nombre: "Chrome", image: UIImage(named: "chrome")!)
//    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        let lines = self.loadDataCSV()
        apps = self.loadUsages(lines: lines)
    }
    func loadDataCSV() -> [String] {
        var usages: [String] = []
        if let path = Bundle.main.path(forResource: "usage", ofType: "csv") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                usages = data.components(separatedBy: .newlines)
            } catch {
                print(error)
            }
        }
        return usages
    }
    func loadUsages(lines: [String]) -> [Usage] {
        var usages: [Usage] = []
        for i in 1...lines.count-2 {
            usages.append(Usage(line: lines[i]))
        }
        return usages
    }
    @IBAction func clickContinuar(_ sender: Any) {
    }
}
extension SeleccionarAppsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}
extension SeleccionarAppsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = apps[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppCell
        cell.tvNombre.text = app.app
        switch app.app {
        case "Reloj": cell.ivLogo.image = UIImage(named: "clock")!
        case "Instagram": cell.ivLogo.image = UIImage(named: "instagram")!
        case "Whatsapp": cell.ivLogo.image = UIImage(named: "whatsapp")!
        case "Facebook": cell.ivLogo.image = UIImage(named: "facebook")!
        case "Gmail": cell.ivLogo.image = UIImage(named: "gmail")!
        case "Chrome": cell.ivLogo.image = UIImage(named: "chrome")!
        default: cell.ivLogo.image = UIImage(named: "clock")!
        }
        return cell
    }
}
