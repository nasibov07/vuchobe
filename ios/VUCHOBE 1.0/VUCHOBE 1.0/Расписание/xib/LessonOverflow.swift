//
//  lessonOverflow.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 03/11/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class LessonOverflow: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var lessonOverflow: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func editButtonActivity(_ sender: Any) {
    }
    
    @IBAction func exitButtonActivity(_ sender: Any) {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        UIView.animate(withDuration: 0.3 , animations: { () -> Void in
            self.view.frame = CGRect(x: 0, y:0,width:
                UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        },completion:{(finished) -> Void in
            self.dismiss(animated: false)
        })
    }
    
    
}

