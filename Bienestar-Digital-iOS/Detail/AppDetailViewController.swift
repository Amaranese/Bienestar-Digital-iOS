//
//  AppDetailViewController.swift
//  Bienestar-Digital-iOS
//
//  Created by Alejandro Marañés on 26/01/2020.
//  Copyright © 2020 Alejandro Marañés. All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController {
    
    var usages: [UsageApps]? = nil
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appName: String = usages!.first!.app
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var openDate: Date!
        var totalUsage: Double = 0
        
        for i in 0...usages!.count-1 {
            if i%2 == 0 { //open
                openDate = dateFormatter.date(from: usages![i].date)!
                
            } else { // close
                let closeDate = dateFormatter.date(from: usages![i].date)!
                let seconds = openDate.distance(to: closeDate)
                totalUsage = totalUsage + seconds
            }
            
        }
        let title = "\(appName) total minutes: \(Int(totalUsage)/60)"
        lbTitle.text = title
        imIcon.image = Utils.loadImage(appName: appName)

        // Do any additional setup after loading the view.
    }
}

extension AppDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}
extension AppDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usages!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = usages![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsageCell", for: indexPath) as! UsageCell
        cell.tvNombre.text = app.app
        cell.tvType.text = app.event
        cell.tvDate.text = app.date
        return cell
    }
}
