//
//  IconTableViewCell.swift
//  wzp_challenge
//
//  Created by james on 14/03/2019.
//  Copyright © 2019 intergoldex. All rights reserved.
//

import UIKit
import Kingfisher
class IconTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowColor  = UIColor.lightGray.cgColor
        containerView.layer.masksToBounds = false
        containerView.layer.shadowOpacity = 0.3
        containerView.backgroundColor = UIColor.white
        
        imgIcon.layer.cornerRadius = 15.0
        imgIcon.layer.masksToBounds = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(_ object: Icon ){
        self.lblTitle.text = object.title
        self.lblSubtitle.text = object.subtitle
        if let url =  object.imageUrl {
            self.imgIcon.kf.indicatorType = .activity
            self.imgIcon.kf.setImage(with: url)
        }else{
            self.imgIcon.image = nil
        }
        
    }
    
}


