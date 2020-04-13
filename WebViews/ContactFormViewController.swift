//
//  ContactFormViewController.swift
//  WebViews
//
//  Created by Dharmatej Parvathaneni on 4/10/20.
//  Copyright © 2020 dharmatej. All rights reserved.
//

import UIKit

class ContactFormViewController: UIViewController, RegIDScanViewDelegate {
    
    @IBAction func showIDScan() {
        self.performSegue(withIdentifier: "regIDScanView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "regIDScanView" {
            let regIDScanVC = segue.destination as! RegIDScanViewController
            regIDScanVC.regIDScanDelegate = self
        }
    }
    
    func captureIDScanResult(regSuccess: String) {
        let alert = UIAlertController(title: "IDScan Result", message: "\(regSuccess)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
