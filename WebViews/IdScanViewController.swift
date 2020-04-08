//
//  FirstViewController.swift
//  WebViews
//
//  Created by Dharmatej Parvathaneni on 4/6/20.
//  Copyright © 2020 dharmatej. All rights reserved.
//

import UIKit

class IdScanViewController: WebViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let cookie = HTTPCookie(properties: [
            .name: "SessionID",
            .domain: ".twinspires.com",
            .path: "/",
            .value: "476f0e78-8d20-44ca-a2ed-33f762201f2d",
            .secure: "FALSE",
            .discard: "TRUE"
        ])!
        
        let userContentHandler = { (_ message: Any) -> Void in
            let dict = message as! [String:AnyObject]
            let regIDScanResult = dict["IDScanStatus"] as! String

            let alert: UIAlertController

            switch regIDScanResult {
                case "SUCCESS":
                    alert = UIAlertController(title: "IDScan Result", message: "Successfully completed IDScan", preferredStyle: .alert)
                default:
                    alert = UIAlertController(title: "IDScan Result", message: "IDScan Failed", preferredStyle: .alert)
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        super.initializeWebView(viewConfig: CustomViewConfig(
            url: URL(string: "http://192.168.1.246:4200/stand-alone/id-scan")!,
            cookies: [cookie],
            userContentName: "IDScanResults",
            scriptHandler: userContentHandler))
    }

}

