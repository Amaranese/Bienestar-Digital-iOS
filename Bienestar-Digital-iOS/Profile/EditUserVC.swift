//
//  EditUserVC.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 17/12/2019.
//  Copyright © 2019 Alejandro Marañés. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class EditUserVC: UIViewController {
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newemail: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newpass: UITextField!
    @IBOutlet weak var repeatnewpass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfile()
    }
    private func loadProfile() {
        let userID = UserDefaults.standard.integer(forKey: "user_id")
        let token = UserDefaults.standard.string(forKey: "token")!
        let url = "http://localhost:8888/Bienestar/public/index.php/api/user/\(userID)";
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Authorization": token]).responseString { [weak self] response in
                            guard let self = self else { return }
                            if response.response!.statusCode == 200 {
                                if let result = response.result.value {
                                    let jsonData = result.data(using: .utf8)!
                                    let user: User = try! JSONDecoder().decode(User.self, from: jsonData)
                                    self.refreshProfile(user)
                                }
                            }
        }
    }
    private func refreshProfile(_ user: User){
        newName.text = user.name
        newemail.text = user.email
    }
    private func updateProfile(){
        if Utils.validateEmptyFields(fields: [newName.text!, newemail.text!]) {
            let alert = UIAlertController(title: "Error", message: "The name or the email fields cannot be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if !Utils.validateEmail(enteredEmail: newemail.text!) {
            let alert = UIAlertController(title: "Error", message: "El email no ha sido escrito de forma correcta", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
}

