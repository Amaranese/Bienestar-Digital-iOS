//
//  RegisterVC.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 16/12/2019.
//  Copyright © 2019 Alejandro Marañés. All rights reserved.
//

import Foundation
import Alamofire
class RegisterVC: UIViewController {
    @IBOutlet weak var textFieldUsuario: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldRepeatPassword: UITextField!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func userRegister(_ sender: UIButton) {
        if textFieldUsuario.text! == "" || textFieldEmail.text! == "" || textFieldPassword.text! == "" || textFieldRepeatPassword.text! == ""{
            let alert = UIAlertController(title: "Error", message: "Has de rellenar todos los campos" as! String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if !validateEmail(enteredEmail: textFieldEmail.text!) {
            let alert = UIAlertController(title: "Error", message: "El email no ha sido escrito de forma correcta" as! String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if textFieldPassword.text!.count < 8{
            let alert = UIAlertController(title: "Error", message: "La contraseña ha de tener un minimo de 8 caracteres" as! String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if textFieldPassword.text != textFieldRepeatPassword.text {
            let alert = UIAlertController(title: "Error", message: "La contraseña de confirmación es incorrecta" as! String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            register()
        }
    }
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    func register() {
        let url = "http://localhost:8888/Bienestar/public/index.php/api/user";
        let parameters: Parameters = [
        "name":textFieldUsuario.text!,
        "email":textFieldEmail.text!,
        "password":textFieldPassword.text!,
        "confirm_password":textFieldRepeatPassword.text!
        ]
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let statusCode = response.response!.statusCode
                print(statusCode)
                if statusCode != 200 {
                    let alert = UIAlertController(title: "Error", message: jsonData["MESSAGE"] as! String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    let token = jsonData["MESSAGE"] as! String
                    let alert = UIAlertController(title: "Enhorabuena", message: "Bienvenido a bienestar digital", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
