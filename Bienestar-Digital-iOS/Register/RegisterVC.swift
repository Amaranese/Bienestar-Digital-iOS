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
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { [weak self] response in
            guard let self = self else { return }
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                let statusCode = response.response!.statusCode
                print(statusCode)
                if statusCode != 200 {
                    let alert = UIAlertController(title: "Error", message: jsonData["MESSAGE"] as! String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    let userToken = jsonData["MESSAGE"] as! String
                    UserDefaults.standard.set(userToken, forKey: "token")
                    UserDefaults.standard.set(true, forKey: "userLogged")
                    let user_id = jsonData["user_id"] as! Int
                    let usages = self.loadUsages(lines: self.loadDataCSV())
                    self.registerUsages(userID: user_id, usages: usages)
                    
                    let alert = UIAlertController(title: "Enhorabuena", message: "Bienvenido a bienestar digital", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                        self.dismiss(animated: true, completion: nil)
//                        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                            appDelegate.startNavViewController()
//                        }
                        
//                        let seleccionaAppsVC = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "SeleccionarAppsVC") as! SeleccionarAppsVC
//                        self.present(seleccionaAppsVC, animated: true, completion: nil)
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    func registerUsages(userID: Int, usages: [Usage]) {
        let url = "http://localhost:8888/Bienestar/public/index.php/api/usagesRegistration";
        let data = UsageRegistration(user_id: userID, usages: usages)
        if let parameters = try? data.asDictionary() {
            Alamofire.request(url,
                              method: .post,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: ["Content-Type": "application/json"]).responseJSON { [weak self] response in
                                guard let self = self else { return }
                                if let result = response.result.value {
                                    let description = response.description
                                    let jsonData = result as! NSDictionary
                                    let statusCode = response.response!.statusCode
                                    print(statusCode)
                                    if statusCode != 200 {
                                    }
                                }
            }
        }
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
}
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

