//
//  ImageTableViewCell.swift
//  ApiwithShimmer
//
//  Created by Subhashini Chandranathan on 16/05/24.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var sampleImage : UIImageView!
    @IBOutlet weak var sampleTitle : UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
