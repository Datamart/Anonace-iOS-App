//
//  ViewController.swift
//  Anonace
//
//  Created by Valentyn Podkamennyi on 2/8/19.
//  Copyright © 2019 Datamart. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    let APP_URL = "https://anonace.com/?utm_source=ios&amp;utm_medium=app"
    let APP_HOST = "anonace.com"

    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: APP_URL)
        var request = URLRequest(url: url!)
        request.httpShouldHandleCookies = false
        webView.load(request)
    }

    /** Handler for external links. */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            if url.host != APP_HOST && url.scheme != "data" {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }

    /** Handler for javascript "confirm" function. */
    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        let ac = UIAlertController(title: "Anonace", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default) {
            _ in completionHandler(true)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .default) {
            _ in completionHandler(false)
        })
        present(ac, animated: true)
    }

//    /** Handler for javascript "alert" function. */
//    func webView(_ webView: WKWebView,
//                 runJavaScriptAlertPanelWithMessage message: String,
//                 initiatedByFrame frame: WKFrameInfo,
//                 completionHandler: @escaping () -> Void) {
//        let ac = UIAlertController(title: "Anonace", message: message, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(ac, animated: true)
//        completionHandler()
//    }
}
