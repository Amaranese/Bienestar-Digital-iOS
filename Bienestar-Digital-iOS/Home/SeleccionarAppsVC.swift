//
//  SeleccionarAppsVC.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 11/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//
import UIKit
import Alamofire
//pantalla de la home, que al iniciar consulta el servicio /usages/list
//la navegacion a otras pantallas es mediante segue
//se intercepta el segue y se pasan los datos requeridos por cada nueva pantalla(viewcontroller)
class SeleccionarAppsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var usages: [UsageApps] = []
    var apps: [App] = []
    var usagesDetail: [UsageApps] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsages()
    }
    @IBAction func clickContinuar(_ sender: Any) {
    }
    private func loadUsages() {
        let url = "http://localhost:8888/Bienestar/public/index.php/api/usages/list";
        let userID = UserDefaults.standard.integer(forKey: "user_id")
        let data = UsagesRequest(user_id: userID)
        if let parameters = try? data.asDictionary() {
            Alamofire.request(url,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: ["Content-Type": "application/json"]).responseString { [weak self] response in
                                guard let self = self else { return }
                                if response.response!.statusCode == 200 {
                                    if let result = response.result.value {
                                        let jsonData = result.data(using: .utf8)!
                                        let usages: [UsageApps] = try! JSONDecoder().decode([UsageApps].self, from: jsonData)
                                        self.updateUsages(usages: usages)
                                    }
                                }
            }
        }
    }
    private func updateUsages(usages: [UsageApps]){
        self.usages = usages
        for usage in usages {
            var found = false
            for app in apps {
                if usage.app == app.name {
                    found = true
                    break
                }
            }
            if !found {
                let image: UIImage = Utils.loadImage(appName: usage.app)
                self.apps.append(App(identifier: usage.id, name: usage.app, image: image))
            }
        }
        self.tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "appDetailSegue") {
            let vc = segue.destination as! AppDetailViewController
            vc.usages = usagesDetail
        } else if (segue.identifier == "mapSegue") {
            let vc = segue.destination as! MapViewController
            vc.usages = usages
        } else if (segue.identifier == "statisticsSegue") {
            let vc = segue.destination as! StatisticsViewController
            vc.usages = usages
        } else if (segue.identifier == "controlSegue") {
            let vc = segue.destination as! ControlViewController
            vc.apps = apps
        }
    }
}
extension SeleccionarAppsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let app = apps[indexPath.row]
        var temp: [UsageApps]  = []
        for usage in usages {
            if usage.app == app.name {
                temp.append(usage)
            }
        }
        self.usagesDetail = temp
        return indexPath
    }
}
extension SeleccionarAppsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = apps[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppCell
        cell.tvNombre.text = app.name
        cell.ivLogo.image = app.image
        return cell
    }
}
