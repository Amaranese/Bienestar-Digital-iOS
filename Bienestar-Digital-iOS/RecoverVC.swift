//
//  RecoverVC.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 16/12/2019.
//  Copyright © 2019 Alejandro Marañés. All rights reserved.
//

import Foundation
import Alamofire
class RecoverVC: UIViewController {
    @IBOutlet weak var mailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func recoverPassword(){
        let url = "http://localhost:8888/BienestarDigital/public/index.php/api/recover";
        let parameters: Parameters=[
            "email":mailField.text!
        ]
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON{response in
            print(response.result.value)
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let statusCode = response.response!.statusCode
                if statusCode != 200 {
                    let alert = UIAlertController(title: "Error", message: jsonData["MESSAGE"] as! String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }else{
                    let alert = UIAlertController(title: "Success", message: "An email has been send with your new password, check your mailbox" as! String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @IBAction func recoverPassAction(_ sender: Any) {
        recoverPassword()
    }
}
