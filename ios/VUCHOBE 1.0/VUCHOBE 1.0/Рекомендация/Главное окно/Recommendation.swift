//
//  Recommendation.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 28/08/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class Recommendation: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var result = [ModelClassContent]()
    var urlAddress = MyURLAddress.shared
    //TableView:
    
    @IBOutlet weak var recommendationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gettingRecommendation(Urlink: urlAddress.UrlForGettingRecommendation)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendationCell") as? RecommendationCell else {
            return UITableViewCell()
        }
        
        cell.titleTextLabel.text = result[indexPath.row].name
        cell.bodyTextLabel.text = result[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecommandationSelf") as! RecommandationSelf
//        if(result[indexPath.row].name != ""){
//            print(result[indexPath.row].name)
//            let a = result[indexPath.row].name
//            vc.titleTextLabel.text = a
//        }else{
//            vc.titleTextLabel.text = "Мероприятие"
//        }
//
//        if(result[indexPath.row].description != ""){
//             vc.bodyTextLabel.text = result[indexPath.row].description
//        }else{
//            vc.titleTextLabel.text = "Новое мероприятие тест"
//            vc.bodyTextLabel.text = result[indexPath.row].description
//        }
        
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gettingRecommendation(Urlink: String){
        let url : NSString = (Urlink + "?size=10&page=0") as NSString
        let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! as NSString
        let searchURL : URL = URL(string: urlStr as String)!
    
        let session = URLSession.shared
        session.dataTask(with: searchURL) { (data, response, error) in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let downloadedResult = try decoder.decode(ModelClass.self, from: data)
                    self.result = downloadedResult.content!
                    
                    let dataStreing = String(data: data, encoding: .utf8)
                    
                    print(dataStreing as Any)
                    DispatchQueue.main.async {
                        if(downloadedResult.totalElements != 0){
                            self.recommendationTableView.reloadData()
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
