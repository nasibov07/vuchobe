//
//  RecommandationSelf.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 30/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class RecommandationSelf: UIViewController {

    //image
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageHigth: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    //textLabel
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var addressTextLabel: UILabel!
    @IBOutlet weak var dataTextLabel: UILabel!
    @IBOutlet weak var orgTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageHigth.constant = view.frame.size.width / 2
        imageWidth.constant = view.frame.size.width
        windowStyle()
    }
    
    func windowStyle(){
        
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.white.cgColor
        followButton.layer.cornerRadius = 20
        
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.layer.cornerRadius = 20
        
    }
    
    @IBAction func backButton(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
}
