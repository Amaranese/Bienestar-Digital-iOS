//
//  ControlViewController.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 10/02/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit
import Alamofire

class ControlViewController: UIViewController {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var maxtime: UITextField!
    
    var apps: [App]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self

        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: UIButton) {
        
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
        loadMaxTime(appName: apps[row].name)
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
