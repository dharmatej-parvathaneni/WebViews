//
//  WebViewController.swift
//  WebViews
//
//  Created by Dharmatej Parvathaneni on 4/6/20.
//  Copyright © 2020 dharmatej. All rights reserved.
//

import UIKit
import WebKit

struct CustomViewConfig {
    var url: URL
    var cookies: [HTTPCookie]?
    var userContentName: String
    var scriptHandler: ((Any) -> Void)?
}

class WebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    var webViewConfig = WKWebViewConfiguration()
    var urlToLoad: URL!
    var userContentHandler: ((Any) -> Void)? = nil

    func initializeWebView(viewConfig: CustomViewConfig) {
        // URL to Load
        self.urlToLoad = viewConfig.url

        // Set Cookies
        if viewConfig.cookies != nil {
            for cookie in viewConfig.cookies! {
                webViewConfig.websiteDataStore.httpCookieStore.setCookie(cookie, completionHandler: nil)
            }
        }

        // Set Method name to leverage from Web Content
        webViewConfig.userContentController.add(self, name: viewConfig.userContentName)
        
        // Set Content Handler from Web to Native
        self.userContentHandler = viewConfig.scriptHandler
}

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func loadView() {
           // WebView configuration
           webViewConfig.applicationNameForUserAgent = "NativeiOSLoadingTUX"

           // Initialize WKWebView
           webView = WKWebView(frame: .zero, configuration: webViewConfig)
           webView.customUserAgent = "NativeiOSLoadingTUX"

           webView.uiDelegate = self
           webView.load(URLRequest(url: self.urlToLoad))

           view = UIView()
           view.addContainedView(webView)
       }

       override func viewDidLoad() {
           super.viewDidLoad()
       }
}

extension WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.userContentHandler?(message.body)
    }
}

extension UIView {

    /// Adds the given view as a subview that fills receiver
    func addContainedView(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addConstraints([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
