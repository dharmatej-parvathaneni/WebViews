//
//  SecondViewController.swift
//  WebViews
//
//  Created by Dharmatej Parvathaneni on 4/6/20.
//  Copyright © 2020 dharmatej. All rights reserved.
//

import UIKit

class ProfileViewController: WebViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        super.initializeWebView(viewConfig: CustomViewConfig(
            url: URL(string: "http://192.168.1.100:4200/")!,
            cookies: nil,
            userContentName: "ProfileView",
            scriptHandler: nil))
    }
}

