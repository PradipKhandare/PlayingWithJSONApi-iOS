//
//  FirstTableViewCell.swift
//  Activity Indicator - 1
//
//  Created by NTS on 31/01/24.
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
        jsonImageView.image = nil
    }
}
