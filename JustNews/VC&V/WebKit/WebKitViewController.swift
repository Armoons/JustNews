//
//  WebKitViewController.swift
//  JustNews
//
//  Created by Stepanyan Arman  on 05.02.2023.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {
    
    var url: URL?
    let webView =  WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.loadRequaest()
    }
    
    func setupUI() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo:view.topAnchor),
            webView.bottomAnchor.constraint(equalTo:view.bottomAnchor)
        ])
    }
    
    func loadRequaest() {
        guard let url = url else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}
