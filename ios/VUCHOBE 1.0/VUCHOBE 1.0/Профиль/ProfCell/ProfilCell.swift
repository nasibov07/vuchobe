//
//  ProfilCell.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 09/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class UniversityCell: UITableViewCell {

    @IBOutlet weak var myTextLabel: UILabel?
    var typeID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class FacultyCell: UITableViewCell {
    
    @IBOutlet weak var myTextLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class QrupCell: UITableViewCell {
    
    @IBOutlet weak var myTextLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
