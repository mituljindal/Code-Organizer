//
//  WebViewController.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 10/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UIBarPositioningDelegate {
    
//    @IBOutlet weak var webView: WKWebView!
    var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var url: URL!
    var request: URLRequest!
    
    func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        
        webView = WKWebView(frame:.zero , configuration: webConfiguration)
        webView.uiDelegate = self
//        view = webView
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":webView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1][v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":webView, "v1":progressView]))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        self.view.backgroundColor = .github
        webView.navigationDelegate = self
//        Observer for progress bar
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: [record], completionHandler: {
                        print("Deleted: " + record.displayName);
                    })
            }
        }
        
        request = URLRequest(url: url)
        webView.load(request)
        webView.scrollView.bounces = false
    }
    
//    Called by login view controller to get OAuth URL
    func getOAuthUrl() {
        url = super.github.getAuthUrl()
    }
    
    deinit { webView.removeObserver(self, forKeyPath: "estimatedProgress") }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
//            Associating progress bar with webview progress
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: false)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        super.github.processOAuthStep1Response(url: webView.url!) { complete in
            if complete {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.presentAlert(title: "Authentication Error", error: "Please try again")
                self.webView.load(self.request)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
//        Processing the url from OAuth step 1
        super.github.processOAuthStep1Response(url: webView.url!) { complete in
            if complete {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.presentAlert(title: "Authentication Error", error: "Please try again")
                self.webView.load(self.request)
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
