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
}
    
