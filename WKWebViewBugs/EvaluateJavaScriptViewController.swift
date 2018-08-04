//
//  EvaluateJavaScriptViewController.swift
//  WKWebViewBugs
//
//  Created by Kyusaku Mihara on 2018/08/04.
//  Copyright © 2018 epohsoft. All rights reserved.
//

import UIKit
import WebKit

class EvaluateJavaScriptViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        let controller = WKUserContentController()

        controller.add(self, name: "messageHandler")
        config.userContentController = controller
        let webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView.navigationDelegate = self
        webView.loadFileURL(.indexHTMLFileURL, allowingReadAccessTo: .indexHTMLFileURL)
        self.webView = webView
    }

    @IBAction func postButtonDidTap(_ sender: Any) {
        clearMessage()
        output(message: "Sending...")

        webView.evaluateJavaScript("postByApp()") { _, error in
            if let error = error {
                self.output(message: "Evaluate javascript error:\(error)")
            }
        }
    }

    private func clearMessage() {
        textView.text = nil
    }

    private func output(message: String) {
        textView.text += "\(message)\n"
    }
}

extension EvaluateJavaScriptViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let messageBody = message.body as? String else {
            output(message: "Message handler error. Body is not string object.\n\(message.body)")
            return
        }

        output(message: messageBody)
    }
}

extension EvaluateJavaScriptViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finish")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Failed:\(error)")
    }
}
