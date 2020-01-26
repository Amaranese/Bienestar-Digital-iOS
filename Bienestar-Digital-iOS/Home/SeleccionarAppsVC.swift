//
//  SeleccionarAppsVC.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 11/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit
import Alamofire

class SeleccionarAppsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var apps: [Usage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
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
                                        let usages: [Usage] = try! JSONDecoder().decode([Usage].self, from: jsonData)
                                        self.updateUsages(usages: usages)
                                    }
                                    
                                }
            }
        }
        
    }
    private func updateUsages(usages: [Usage]){
        self.apps = usages
        self.tableView.reloadData()
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
