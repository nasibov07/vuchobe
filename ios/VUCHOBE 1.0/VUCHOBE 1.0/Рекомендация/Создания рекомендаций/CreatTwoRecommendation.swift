//
//  CreatTwoRecommendation.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 15/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class CreatTwoRecommendation: UIViewController, UITextViewDelegate {
    
    //MyTokan
    var userData = UserData.shared
    var imagePicker: UIImagePickerController!
    @IBOutlet weak var imageViewWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeigthConstant: NSLayoutConstraint!
    var myUrlAddress = MyURLAddress.shared
    
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var image: UIImageView!
    var imageBigBase64: String = ""
    
    @IBOutlet weak var nextButton:      UIButton!
    @IBOutlet weak var backButton:      UIButton!
    
    @IBOutlet weak var titleLabel:      UILabel!
    @IBOutlet weak var addressLabel:    UILabel!
    @IBOutlet weak var dataLabel:       UILabel!
    @IBOutlet weak var orgLabel:        UILabel!
    @IBOutlet weak var myTextView:      UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    //Название мероприятия
    var recommendationName: String = ""
    //Краткая информация
    var shortName: String = ""
    //Название огранизации
    var orgName: String = ""
    //Адресс
    var recommendationAddress: String = ""
    //Дата
    var recommendationData: String = ""
    //Тип
    var typeName: String = ""
    //Изображение
    var imageLittle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreatRecommendationStyle()
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(imageTap)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        
        titleLabel.text = recommendationName
        addressLabel.text = recommendationAddress
        dataLabel.text = recommendationData
        orgLabel.text = orgName
        
        myTextView.delegate = self
        print(orgName)
        print(recommendationAddress)
        print(recommendationData)
        print(typeName)
        print(recommendationName)
        print(shortName)
        print(imageLittle)
    }
    
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func CreatRecommendationStyle(){
        
        addImage.tintColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        addImage.layer.cornerRadius = addImage.frame.size.width / 2
        addImage.clipsToBounds = true
        
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.cornerRadius = 20
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.layer.cornerRadius = 20
        
        imageViewWidthConstant.constant = view.frame.size.width
        imageViewHeigthConstant.constant = view.frame.size.width
        
        //imageViewConstant.constant = view.frame.width / 2
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let width = 500
        let height = 500
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    //Нахождения максимального значение среди двух чисел
    func findMax(width: CGFloat , height : CGFloat) -> CGFloat{
        if( width > height ){
            return width
        }else{
            return height
        }
    }
    
    //Нахождения минимального значение среди двух чисел
    func findMin(width: CGFloat , height : CGFloat) -> CGFloat{
        if( width > height ){
            return height
        }else{
            return width
        }
    }
    
    func requestForAddRecommendation(URLink : String){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let json: [String: Any] = [
            "instituteId": 6,
            "typeId": 7,
            "name": recommendationName,
            "shortDescription": shortName,
            "description": myTextView.text!,
            "imagesBase64": [
                imageLittle,
                imageBigBase64
            ],
             "address": [
                "fullAddress": recommendationAddress
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: "\(URLink)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userData.tokan)", forHTTPHeaderField: "Authorization")
        // Устанавливаем тело в запросе
        request.httpBody = jsonData
        let task = session.dataTask(with: request){
            data, response, error in guard let _ = data, error == nil
                else{
                    print(error as Any)
                    return
            }
            let a = String(data: data!, encoding: .utf8)
            print("data:", a as Any)
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                print("ERROR")
                
            }else{
                print("Saccess")
            }
            
        };task.resume()
    }
    
    @IBAction func readyButton(_ sender: Any) {
        requestForAddRecommendation(URLink: myUrlAddress.UrlForCreatRecommendation)
    }
    
    //MARk: -Работа с клавиатурой:----------------------------начало
    //Нажатие на RETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    //Нажатие на любое место
    @IBAction func tapDo(_ sender: Any) {
        myTextView.resignFirstResponder()
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

extension CreatTwoRecommendation: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let a = self.resizeImage(image: pickedImage, newWidth: view.frame.size.width)
            self.image.image = a
            let imageData   = image.image!.pngData()!
            imageBigBase64  = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
