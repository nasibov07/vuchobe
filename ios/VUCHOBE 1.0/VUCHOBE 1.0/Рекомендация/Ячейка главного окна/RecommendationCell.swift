//
//  RecommendationCell.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 28/08/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class RecommendationCell: UITableViewCell {
    //View:
    //Главыное view
    @IBOutlet weak var mainView: UIView!
    //Нижнее view
    @IBOutlet weak var cardView: UIView!
    //Image:
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var imageViewConstant: NSLayoutConstraint!
    @IBOutlet weak var mainViewConstrain: NSLayoutConstraint!
    
    //textLabel
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func cellStyle(){
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 15
        cardView.clipsToBounds = true
        
        mainImage.layer.cornerRadius = 15
        mainImage.clipsToBounds = true
        
        imageViewConstant.constant = (mainView.frame.width / 2) - 50
        mainViewConstrain.constant =  (imageViewConstant.constant + 100)
    }
}
