//
//  ViewController.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 13/12/2019.
//  Copyright © 2019 Alejandro Marañés. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func checkLogin() {
        let url = "http://localhost:8888/BienestarDigital/public/index.php/api/users";
        let parameters : Parameters=[
            "email":textFieldEmail.text!,
            "password":textFieldPassword.text!
        ]
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON {
            response in
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let statusCode = response.response!.statusCode
                if statusCode != 200 {
                    let alert = UIAlertController(title: "Error", message: jsonData["MESSAGE"] as! String, preferredStyle: .alert)
                }
            }
        }
    }


}

