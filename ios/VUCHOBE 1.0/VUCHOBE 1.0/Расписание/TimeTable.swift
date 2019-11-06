//
//  TimeTable.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 02/11/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class TimeTable: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let result = [
        "12.10 \nПН",
        "Инф.\nАуд. 5217",
        "ТП\nАуд. 5217",
        "ИНО\nАуд. 5217",
        "Матен.\nАуд. 5217",
        "","",
        
        "13.10 \nВТ",
        "","ИНО\nАуд. 5217","Инф.\nАуд. 5217","Физ-ра\nАуд. 5217","","",
        
        "14.10 \nСР",
        "","","","","","",
        
        "15.10 \nЧТ",
        "","","","","Матан.\nАуд. 5217","ТП\nАуд. 5217",
        
        "16.10 \nПТ",
        "БД\nАуд. 5217","ИС\nАуд. 5217","МО\nАуд. 5217","","","",
        
        "17.10 \nСБ",
        "ИНО\nАуд. 5217","КИС\nАуд. 5217","КИС\nАуд. 5217","","",""
    ]
    
    @IBOutlet weak var collViewLesson: UICollectionView!
    
    var i: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    
    func style(){
      
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return result.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeTableLessonCollectionCell", for: indexPath) as? TimeTableLessonCollectionCell else{
            return UICollectionViewCell()
        }
        print(i)
        cell.myTextLabel.text = result[indexPath.row]
        
        if(i == 0){
            cell.myViewConstraintWidth.constant = CGFloat(collViewLesson.frame.size.width / 5)
            cell.myViewConstraintHeight.constant = CGFloat(50)
            cell.myView.layer.backgroundColor = UIColor.white.cgColor
            cell.myTextLabel.textColor = UIColor.black
            i+=1
            
        }else if(i == 6){
            i = 0
            cell.myViewConstraintHeight.constant = CGFloat((collViewLesson.frame.size.height - 50) / 6)
            cell.myViewConstraintWidth.constant = CGFloat(collViewLesson.frame.size.width / 5)
            cell.myView.layer.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1.0).cgColor
            cell.myTextLabel.textColor = UIColor.white
            cell.myView.layer.borderWidth = 0.4
            cell.myView.layer.borderColor = UIColor.white.cgColor
            
        }else{
            cell.myViewConstraintHeight.constant = CGFloat((collViewLesson.frame.size.height - 50) / 6)
            cell.myViewConstraintWidth.constant = CGFloat(collViewLesson.frame.size.width / 5)
            cell.myView.layer.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 1.0).cgColor
            cell.myTextLabel.textColor = UIColor.white
            cell.myView.layer.borderWidth = 0.4
            cell.myView.layer.borderColor = UIColor.white.cgColor
            i+=1
        }
        
        if(result[indexPath.row] == ""){
            cell.myView.layer.backgroundColor = UIColor(red: 0/255, green: 150/255, blue: 255/255, alpha: 0.0).cgColor
            cell.myView.layer.borderWidth = 0.4
            cell.myView.layer.borderColor = UIColor.white.cgColor
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let vc : LessonOverflow = self.storyboard!.instantiateViewController(withIdentifier: "LessonOverflow") as! LessonOverflow
        vc.modalPresentationStyle = .overCurrentContext
        
        vc.view.frame = CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            vc.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        }, completion:nil)
        self.present(vc, animated: false, completion: nil);
    }
}
