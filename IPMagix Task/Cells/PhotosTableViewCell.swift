//
//  PhotosTableViewCell.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/28/21.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!    
    @IBOutlet weak var testLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
