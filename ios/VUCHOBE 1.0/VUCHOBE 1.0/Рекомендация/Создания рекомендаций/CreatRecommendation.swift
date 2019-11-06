//
//  CreatRecommendation.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 13/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class CreatRecommendation: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    //SEGUEY send data to second VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: CreatLittleCard = segue.destination as! CreatLittleCard
        destinationVC.orgName = nameOrder.text!
        destinationVC.recommendationData = dataTime.text!
        destinationVC.recommendationAddress = nameAddress.text!
        destinationVC.typeName = comboBoxTitle.text!
       }
    
    //scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Сингле тон
    var myUrlAddress = MyURLAddress.shared
    var resultGetType = [ModelClassContent]()
    
    //MyTokan
    var userData = UserData.shared
    
    //view:
    @IBOutlet weak var typeView: UIView!
    
    //image:
    @IBOutlet weak var typeViewImage: UIImageView!
    
    //TextView:
    @IBOutlet weak var nameOrder: UITextField!
    @IBOutlet weak var nameAddress: UITextField!
    @IBOutlet weak var dataTime: UITextField!
    
    //ComboBox
    @IBOutlet weak var comboBoxTitle: UILabel!
    @IBOutlet weak var ComboBoxConstant: NSLayoutConstraint!
    var ComboBoxTypeID: Int?
    var ComboBoxBool: Bool = false
    var typeTotal: Int = 0                                  //количество элементов в comboBox
    
    //Button:
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    //TableView
    @IBOutlet weak var tableView: UITableView!
    
    //
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CreatRecommendationStyle()
        
        let Url = myUrlAddress.UrlForGettingType
        requestForGettingType(url: Url)
        
        nameOrder.delegate = self
        nameAddress.delegate = self
    }
    
    //backButton
    @IBAction func backButtonAction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    //Функция стиля
    func CreatRecommendationStyle(){
        
        nameOrder.attributedPlaceholder = NSAttributedString(string: "НАЗВАНИЕ ОРГАНИЗАЦИИ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.cornerRadius = 20
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.layer.cornerRadius = 20
        
        ComboBoxConstant.constant = 0
        
        typeView.layer.borderWidth = 1
        typeView.layer.borderColor = UIColor.white.cgColor
        typeViewImage.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        nameAddress.attributedPlaceholder = NSAttributedString(string: "АДРЕС",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        dataTime.attributedPlaceholder = NSAttributedString(string: "ДАТА ПРОВЕДЕНИЯ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    //Зпрос на получения типа рекомендации
    func requestForGettingType(url: String){
        let url = URL(string: "\(url)")!
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //guard let token = token else { return }
        request.setValue("Bearer \(userData.tokan)", forHTTPHeaderField: "Authorization")
        // Устанавливаем тело в запросе
        
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let downloadedResult = try decoder.decode(ModelClass.self, from: data)
                    self.resultGetType = downloadedResult.content!
                    let dataStreing = String(data: data, encoding: .utf8)
                    print(dataStreing as Any)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                        if(downloadedResult.totalElements != 0){
                            self.typeTotal = downloadedResult.totalElements!
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    @IBAction func getTypeRecommandation(_ sender: Any) {
        print("Кнопка нажата")
        if(ComboBoxBool != true){
            ComboBoxConstant.constant = CGFloat(40 * typeTotal)
            ComboBoxBool = true
            print(ComboBoxBool)
        }else{
            ComboBoxConstant.constant = 0
            ComboBoxBool = false
            print(ComboBoxBool)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultGetType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UniversityCell") as? UniversityCell else{
            return UITableViewCell()
        }
        
        cell.myTextLabel?.text = resultGetType[indexPath.row].name
        cell.typeID = resultGetType[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(tableView == tableView){
            self.comboBoxTitle.text = resultGetType[indexPath.row].name
            self.ComboBoxTypeID = resultGetType[indexPath.row].id
            self.ComboBoxConstant.constant = 0
            ComboBoxBool = false
        }
    }
    
    @IBAction func dataGetButtonActivity(_ sender: Any) {
        let dataPicker = MyDataPicker()
        view.addSubview(dataPicker)
        dataPicker.frame.size = CGSize(width: 300, height: 350)
        dataPicker.didMoveToWindow()
        dataPicker.center = self.view.center
        dataPicker.enterButton.addTarget(self, action: #selector(getdata(sender: )), for: .touchUpInside)
    }
    
    @objc func getdata(sender: UIButton){
        print(sender.titleLabel?.text as Any)
        dataTime.text = sender.titleLabel?.text
    }
    
    //MARk: -Работа с клавиатурой:----------------------------начало
       
       //Нажатие на RETURN
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return (true)
       }
       
       deinit {
           removeKeyboardNotifications()
       }
       
       //Показать клавиатуру
       func registerForKeyboardNotifications() {
           NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardDidHideNotification , object: nil)
       }
       
       func removeKeyboardNotifications() {
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification , object: nil)
       }
       
       @objc func kbWillShow(_ notification: Notification) {
           let userInfo = notification.userInfo
           let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
           scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
       }
       
       @objc  func kbWillHide() {
           scrollView.contentOffset = CGPoint(x: 0, y: 0)
       }
       //Работа с клавиатурой:----------------------------конец
}
