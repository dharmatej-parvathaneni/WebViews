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
        
        super.initializeWebView(viewConfig: CustomViewConfig(
            url: URL(string: "http://192.168.1.100:4200/stand-alone/id-scan")!,
            cookies: [cookie],
            userContentName: "IDScanResults"))
    }

}

