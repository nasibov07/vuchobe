//
//  MyDataPicker.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 05/10/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class MyDataPicker: UIView {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var chaildView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var dLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    
    @IBOutlet weak var enterButton: UIButton!

    @IBAction func cloaseButton(_ sender: Any) {
        self.removeFromSuperview()
    }
    @IBAction func enterButtonActivity(_ sender: Any) {
        enterButton.titleLabel?.text = "\(formattedDateDMY)"
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          commonInit()
          cardViewStyle()
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          commonInit()
          cardViewStyle()
      }
      
      private func commonInit(){
          Bundle.main.loadNibNamed("MyDataPicker", owner: self, options: nil)
          addSubview(mainView)
          mainView.frame = self.bounds
          mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
          
        
        dataPicker.addTarget(self, action: #selector(self.dateChanged), for: UIControl.Event.valueChanged)
      }
    
    @objc func dateChanged(sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            print("\(day) \(month) \(year)")
            dLabel.text = String(day)
            mLabel.text = String(formattedDate)
            yLabel.text = String(year)
        }
    }
    
    var formattedDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: dataPicker.date)
    }
    
    var formattedDateDMY: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: dataPicker.date)
    }
    
    func cardViewStyle(){
        
        titleView.layer.cornerRadius = 20
        
        buttonView.layer.cornerRadius = 20
        
        chaildView.layer.cornerRadius = 20
        chaildView.layer.borderWidth = 1
        chaildView.layer.borderColor = UIColor.white.cgColor
        
        enterButton.layer.borderWidth = 1
        enterButton.layer.borderColor = UIColor.black.cgColor
        enterButton.layer.cornerRadius = 20
        
//        dataPicker.setValue(UIColor.white, forKeyPath: "textColor")
//        dataPicker.setValue(false, forKey: "highlightsToday")
//        dataPicker.backgroundColor = UIColor.black
    }

}
