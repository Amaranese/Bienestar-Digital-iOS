//
//  ControlViewController.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 10/02/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit

class ControlViewController: UIViewController {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var maxtime: UITextField!
    @IBAction func save(_ sender: UIButton) {
    }
    
    var apps: [App]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    

}
extension ControlViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return apps[row].name
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
