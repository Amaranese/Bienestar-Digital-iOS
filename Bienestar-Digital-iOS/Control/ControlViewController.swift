//
//  ControlViewController.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 10/02/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit
import Alamofire
//Al iniciar la pantalla se consulta el servicio control/read
//Para guardar un tiempo maximo se usa el servicio control/update
class ControlViewController: UIViewController {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var maxtime: UITextField!
    
    var apps: [App]!
    private var appSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self

        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: UIButton) {
        if let maxTimeInMinutes = Int(maxtime.text!), appSelected.count > 0 {
            saveMaxTime(appName: appSelected, maxTime: maxTimeInMinutes)
        }
    }
    private func saveMaxTime(appName: String, maxTime: Int){
        let token = UserDefaults.standard.string(forKey: "token")!
        let userID = UserDefaults.standard.integer(forKey: "user_id")
        let url = "http://localhost:8888/Bienestar/public/index.php/api/control/update";
        let data = ControlAppActualizacion(user_id: userID, app_name: appName, max_time: maxTime)
        if let parameters = try? data.asDictionary() {
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default,
                              headers: ["Content-Type": "application/json", "Authorization": token]).responseString { [weak self] response in
                                guard let self = self else { return }
                                if response.response!.statusCode == 200 {
                                    let alert = UIAlertController(title: "Success", message: "Max time updated", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true)
                                } else {
                                    let alert = UIAlertController(title: "Error", message: "Error updating max time", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true)
                                }
            }
        }
    }
    
    private func loadMaxTime(appName: String) {
        let token = UserDefaults.standard.string(forKey: "token")!
        let userID = UserDefaults.standard.integer(forKey: "user_id")
        let url = "http://localhost:8888/Bienestar/public/index.php/api/control/read";
        let data = ControlAppConsulta(user_id: userID, app_name: appName)
        if let parameters = try? data.asDictionary() {
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default,
                              headers: ["Content-Type": "application/json", "Authorization": token]).responseString { [weak self] response in
                                guard let self = self else { return }
                                if response.response!.statusCode == 200 {
                                    if let result = response.result.value, result != "{}" {
                                        let jsonData = result.data(using: .utf8)!
                                        let resp: ControlAppConsultaResponse = try! JSONDecoder().decode(ControlAppConsultaResponse.self, from: jsonData)
                                        self.maxtime.text = "\(resp.max_time)"
                                    } else {
                                        self.maxtime.text = ""
                                    }
                                }
            }
        }
        
    }

}
extension ControlViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return apps[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        appSelected = apps[row].name
        loadMaxTime(appName: appSelected)
    }
}
extension ControlViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return apps.count
    }
}
