//
//  ViewController.swift
//  JustNews
//
//  Created by Stepanyan Arman  on 03.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var hasMore = true
    var currPage = 1
    let mainView = MainView()
    let parser = Parser()
    var newsArray: [Article] = []
    let cache = NewsModelCache()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.tintColor = .red

        getDate(.table)
        
        mainView.getDatesCount = { [weak self] in
            return self?.newsArray.count ?? 0
        }
        
        mainView.getDateForIndex = { [weak self] date in
            return self?.newsArray[date]
        }
        
        mainView.getDate = { [weak self] by in
            self?.getDate(by)
        }
        
        mainView.presentNews = { [weak self] article in
            let nvc = NewsViewController()
            nvc.sendInfo(info: article)
            self?.increaseViewsByID(id: article.url.absoluteString)
            self?.mainView.updateTable()
            self?.navigationController?.pushViewController(nvc, animated: true)
        }
        
        mainView.getViewsByID = { [weak self] id in
            self?.getViewsByID(id: id) ?? 0
            
        }
    }
    
    func getViewsByID(id:String)->Int {
        UserDefaults.standard.integer(forKey: id)
    }
    
    func increaseViewsByID(id:String) {
        let views = UserDefaults.standard.integer(forKey: id)
        UserDefaults.standard.set(views+1, forKey: id)

    }
    func getDate(_ by: getInfoBy) {
        
        guard hasMore else { return }
        parser.getInfo(page: currPage) { [weak self] result in
            guard let self else { return }
            switch result {
            case .failure:
                if !self.newsArray.elementsEqual(NewsModelCache.get(), by: {$0.url == $1.url}) {
                    self.newsArray = NewsModelCache.get()
                    self.mainView.updateTable()
                }
            case .success(let data):
                self.currPage += 1

                if by == .pull {
                    self.newsArray = []
                    NewsModelCache.remove()
                }
                
                if data.isEmpty {
                    self.hasMore = false
                }
                
                self.newsArray.append(contentsOf: data)
                NewsModelCache.save(value: self.newsArray)
                self.mainView.updateTable()
            }
    
        }

    }
}

enum getInfoBy {
    case pull
    case table
}
