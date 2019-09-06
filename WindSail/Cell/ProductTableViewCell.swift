//
//  ProductTableViewCell.swift
//  WindSail
//
//  Created by Samit Koyom on 6/9/2562 BE.
//  Copyright © 2562 Samit Koyom. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productBarcode: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
