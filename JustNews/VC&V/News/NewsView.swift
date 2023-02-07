//
//  NewsView.swift
//  JustNews
//
//  Created by Stepanyan Arman  on 05.02.2023.
//

import UIKit

class NewsView: UIView {
    
    var newsInfo: Article?
    
    var pesentWebKit: ((URL)->())?
    
    private var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isDirectionalLockEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        
        return sv
    }()
    
    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let urlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(titleTapped))
        titleLabel.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func titleTapped() {
        self.pesentWebKit!(newsInfo!.url)
    }
    
    func getInfo(info: Article) {
        newsInfo = info
        setupContent()
    }
    
    func setupContent() {
        guard let newsInfo = newsInfo else { return }
        ImageProvider.shared.downloadImage(url: newsInfo.urlToImage) { image in
            self.imageView.image = image
        }
        self.titleLabel.text = newsInfo.title
        self.sourceLabel.text = newsInfo.source.name
        self.dateLabel.text = newsInfo.publishedAt
        self.descriptionLabel.text = newsInfo.description
    }
    
    func setupUI() {
        
        self.addSubview(scrollView)
        
        for view in [titleLabel, sourceLabel, dateLabel, descriptionLabel, imageView] {
            contentView.addSubview(view)
        }
        
        scrollView.addSubview(contentView)
        
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 8/12).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        
        sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        let scrollCG = scrollView.contentLayoutGuide
        let scrollFG = scrollView.frameLayoutGuide
        
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        contentView.leftAnchor.constraint(equalTo: scrollCG.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollCG.rightAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollCG.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollCG.bottomAnchor).isActive = true
        
        contentView.leftAnchor.constraint(equalTo: scrollFG.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollFG.rightAnchor).isActive = true
    }
}
