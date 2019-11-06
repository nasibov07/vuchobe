//
//  AboutUniversity.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 30/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class AboutUniversity: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    //CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    var littleImage = [
                        UIImage(named: "samgupssss"),
                        UIImage(named: "mapsss"),
                        UIImage(named: "restoran")
    ]
    var bigImage = [
                        UIImage(named: "bigImage1"),
                        UIImage(named: "bigImage2"),
                        UIImage(named: "bigImage3")
    ]
    
    var bigUniver = [
                           "Ректорат",
                           "Деконат",
                           "Кафедра"
       ]
    
    var infUniver = [
                        "Новости",
                        "Карта",
                        "Столовая"
    ]
    
    var bodyUniver = [
                        "Сегодня прошла встреча проректора по науке ...",
                        "Первый корпус находится на улице ...",
                        "Вы можите посмотреть стоимость ..."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return littleImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UniversityCollectionCell",for: indexPath) as! UniversityCollectionCell
        cell.bigImage.image = bigImage[indexPath.row]
        cell.titleLabel.text = bigUniver[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bigUniver.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UniversityCollectionViewCellTwo",for: indexPath) as! UniversityCollectionViewCellTwo
        cell.bigImage.image = littleImage[indexPath.row]
        cell.tableViewLabelOne.text = infUniver[indexPath.row]
        cell.tableViewLabelTwo.text = bodyUniver[indexPath.row]
        
        return cell
    }
    
}
