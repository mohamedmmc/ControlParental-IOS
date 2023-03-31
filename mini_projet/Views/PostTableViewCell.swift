//
//  PostTableViewCell.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 1/12/2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleField: UILabel!
  
    
    @IBOutlet weak var DescriptionField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
