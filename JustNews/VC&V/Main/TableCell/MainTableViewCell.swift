//
//  MainTableViewCell.swift
//  JustNews
//
//  Created by Stepanyan Arman  on 03.02.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let cellID = "MainTableViewCell"

    @IBOutlet weak var countL: UILabel!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageV.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
