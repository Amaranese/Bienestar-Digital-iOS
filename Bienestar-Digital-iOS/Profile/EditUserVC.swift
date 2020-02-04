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
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var newName: UITextField!
    @IBOutlet weak var newemail: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newpass: UITextField!
    @IBOutlet weak var repeatnewpass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfile()
    }
    @IBAction func logout(_ sender: Any) {
    }
    @IBAction func updateProfile(_ sender: Any) {
        updateProfile()
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
        userName.text = user.name
        userEmail.text = user.email
    }
    private func updateProfile(){
        //if (empty($request->name) && empty($request->email) && empty($request->newPassword))
        if newName.text!.isEmpty && newemail.text!.isEmpty && newpass.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "You have to fill at least one field: new name or new email or new password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        if !newemail.text!.isEmpty && !Utils.validateEmail(enteredEmail: newemail.text!) {
            let alert = UIAlertController(title: "Error", message: "El email no ha sido escrito de forma correcta", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        if !newpass.text!.isEmpty && (repeatnewpass.text!.isEmpty || oldPassword.text!.isEmpty) {
            let alert = UIAlertController(title: "Error", message: "You have to fill at password fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

