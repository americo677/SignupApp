//
//  ActivityLogTableViewCell.swift
//  SignupApp
//
//  Created by Américo Cantillo Gutiérrez on 9/08/21.
//

import UIKit

class ActivityLogTableViewCell: UITableViewCell {

    @IBOutlet var activityResultLabel: UILabel! = {
        let label = UILabel()
        return label
    }()
    
    @IBOutlet var activityDateLabel: UILabel! = {
        let label = UILabel()
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
