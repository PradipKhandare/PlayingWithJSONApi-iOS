//
//  FirstTableViewCell.swift
//  LazyLoading WebApi tableView
//
//  Created by NTS on 01/02/24.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var jsonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        jsonImageView.image = UIImage(named: "1")
    }

}
