//
//  ActivityCell.swift
//  NotBored
//
//  Created by Jorge Andres Restrepo Gutierrez on 7/06/22.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    @IBOutlet weak var activityTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.accessoryType = .disclosureIndicator
    }
    
}
