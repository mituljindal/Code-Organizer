//
//  WebViewController.swift
//  GitHub-OnTheGo
//
//  Created by mitul jindal on 10/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class WebViewController: UIViewController, WKNavigationDelegate {
    
    let github = GitHubClient.sharedInstance
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var request: URLRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        let url = github.getAuthUrl()
        request = URLRequest(url: url)
        webView.load(request)
    }
    
    deinit { webView.removeObserver(self, forKeyPath: "estimatedProgress") }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        github.processOAuthStep1Response(url: webView.url!) { complete in
            if complete {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
