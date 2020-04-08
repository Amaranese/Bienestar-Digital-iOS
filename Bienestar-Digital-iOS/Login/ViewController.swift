//
//  ViewController.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 13/12/2019.
//  Copyright © 2019 Alejandro Marañés. All rights reserved.
//
import UIKit
import Alamofire
//Pantalla de login que usa el servicio "login"
//Se solicuta al usuario permiso de recibir notificaciones si hiciera falta
class ViewController: UIViewController {
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBAction func onNotifications(_ sender: Any) {
        if let messagesSwitch = sender as? UISwitch {
            if messagesSwitch.isOn {
                let alert = UIAlertController(title: "Success", message: "Now you will receive notifications", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Success", message: "Now you will NOT receive notifications anymore", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
            }
        }
    }
    @IBAction func onMessages(_ sender: Any) {
        if let messagesSwitch = sender as? UISwitch {
            if messagesSwitch.isOn {
                let alert = UIAlertController(title: "Success", message: "Now you will receive messages", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Success", message: "Now you will NOT receive messages anymore", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func checkLogin() {
        let url = "http://localhost:8888/Bienestar/public/index.php/api/login";
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
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    let arrayToken = response.result.value as! [String:Any]
                    let userToken = arrayToken["MESSAGE"]!
                    let user_id = arrayToken["user_id"]!
                    UserDefaults.standard.set(userToken, forKey: "token")
                    UserDefaults.standard.set(true, forKey: "userLogged")
                    UserDefaults.standard.set(user_id, forKey: "user_id")
                    let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                    let navVC: UINavigationController
                    navVC = storyBoard.instantiateViewController(withIdentifier: "navigation") as! UINavigationController
                    self.present(navVC, animated: true)
                }
            }
        }
    }
    @IBAction func Login(_ sender: UIButton) {
        if textFieldEmail.text! == "" || textFieldPassword.text! == ""{
            let alert = UIAlertController(title:"Error", message: "Has de rellenar todos los campos" as! String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if !validateEmail(enteredEmail: textFieldEmail.text!){
            let alert = UIAlertController(title: "Error", message: "El email no es correcto" as! String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if textFieldPassword.text!.count < 8{
            let alert = UIAlertController(title: "Error", message: "La contraseña no es correcta" as! String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
        }else{
            print("Llego")
        }
        checkLogin()
    }
    func validateEmail(enteredEmail:String)-> Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"Self Matches %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
}
