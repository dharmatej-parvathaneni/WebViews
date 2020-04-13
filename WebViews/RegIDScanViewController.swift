//
//  RegIDScanViewController.swift
//  WebViews
//
//  Created by Dharmatej Parvathaneni on 4/13/20.
//  Copyright © 2020 dharmatej. All rights reserved.
//

import UIKit

protocol RegIDScanViewDelegate: class {
    func captureIDScanResult(regSuccess: String)
}

class RegIDScanViewController: WebViewController {
    
    var regIDScanDelegate : RegIDScanViewDelegate!
    
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
            
            if (dict["CloseIDScan"] as? Bool) != nil {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
            
            if (dict["ShowCreateAccount"] as? Bool) != nil {
                // Start Navigation
                self.presentingViewController?.dismiss(animated: true, completion: nil)
                
                self.regIDScanDelegate?.captureIDScanResult(regSuccess: "Successfully Completed IDScan")
                
            }
         }
         
         super.initializeWebView(viewConfig: CustomViewConfig(
            url: URL(string: "http://192.168.1.100:4200/stand-alone/id-scan")!,
            cookies: [cookie],
            userContentName: "IDScanResults",
            scriptHandler: userContentHandler))
    }
}
