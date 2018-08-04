//
//  WebViewController.swift
//  WKWebViewBugs
//
//  Created by Kyusaku Mihara on 2018/08/04.
//  Copyright © 2018 epohsoft. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadFileURL(.indexHTMLFileURL, allowingReadAccessTo: .indexHTMLFileURL)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Error: \(error)")
    }
}
