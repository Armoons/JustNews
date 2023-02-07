//
//  MainView.swift
//  JustNews
//
//  Created by Stepanyan Arman  on 03.02.2023.
//

import UIKit

class MainView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    
    var getDatesCount: (() -> (Int))?
    
    var getDateForIndex: ((Int) -> (Article)?)?
    
    var getDate: ((_ : getInfoBy)->())?
    
    var presentNews: ((Article)->())?
    
    var getViewsByID: ((String)->(Int))?
    
    
    let refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshTable(sender:)), for: .valueChanged)
        return rc
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UINib(nibName: MainTableViewCell.cellID, bundle: nil), forCellReuseIdentifier: MainTableViewCell.cellID)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        setupUI()
    }
    
    @objc func refreshTable(sender: UIRefreshControl) {
        self.getDate!(.pull)
        sender.endRefreshing()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getDatesCount?() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = getDateForIndex?(indexPath.row) else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.cellID, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.titleL.text = model.title
        ImageProvider.shared.downloadImage(url: model.urlToImage) { image in
            cell.imageV.image = image
        }
        cell.countL.text = "\(self.getViewsByID!(model.url.absoluteString))"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func updateTable() {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == getDatesCount!() - 4 {
            self.getDate!(.table)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presentNews!((getDateForIndex?(indexPath.row))!)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    private func setupUI() {
        self.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}


