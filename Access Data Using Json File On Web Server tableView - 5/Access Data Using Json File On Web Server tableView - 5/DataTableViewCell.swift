//
//  DataTableViewCell.swift
//  Access Data Using Json File On Web Server tableView - 5
//
//  Created by NTS on 30/01/24.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
