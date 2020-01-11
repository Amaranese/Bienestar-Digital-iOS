//
//  SeleccionarAppsVC.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 11/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit

class SeleccionarAppsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let apps = [
        App(nombre: "Whatsapp", image: UIImage(named: "whatsapp")!),
        App(nombre: "Instagram", image: UIImage(named: "instagram")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
    }
    
    @IBAction func clickContinuar(_ sender: Any) {
        
    }
    
}

extension SeleccionarAppsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}

extension SeleccionarAppsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = apps[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! AppCell
        cell.ivLogo.image = app.image
        cell.tvNombre.text = app.nombre
        return cell
    }
    
}
