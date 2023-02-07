//
//  NewsViewController.swift
//  JustNews
//
//  Created by Stepanyan Arman  on 05.02.2023.
//

import UIKit

class NewsViewController: UIViewController {
    
    let newsView = NewsView()
    
    override func loadView() {
        self.view = newsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsView.pesentWebKit = { [weak self] url in
            let vc = WebKitViewController()
            vc.url = url
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func sendInfo(info: Article) {
        newsView.getInfo(info: info)
    }
}
