//
//  CreatLittleCard.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 24/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class CreatLittleCard: UIViewController, UITextFieldDelegate {

    //MARK: SEGUEY
    //SEGUEY send data to second VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationVC: CreatTwoRecommendation = segue.destination as! CreatTwoRecommendation
        destinationVC.orgName = orgName
        destinationVC.recommendationData = recommendationData
        destinationVC.recommendationAddress = typeName
        destinationVC.typeName = typeName
        destinationVC.recommendationName = nameRecommendationLabel.text!
        destinationVC.shortName = shortDescriptionLabel.text!
        destinationVC.imageLittle = imageBase64
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
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imagePicker: UIImagePickerController!
    var imageBase64: String = ""
    //Получаю с первого VC
    //Название организации
    var orgName: String = ""
    //Адресс
    var recommendationAddress: String = ""
    //Дата
    var recommendationData: String = ""
    //Тип
    var typeName: String = ""
    var imageBigBase64: String = ""
    //Label
    @IBOutlet weak var nameRecommendationLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    //view
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var mainCardView: UIView!
    
    //image
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var addImage: UIImageView!
    
    //textView
    @IBOutlet weak var nameRecommendation: UITextField!
    @IBOutlet weak var shortDescription: UITextField!
    
    //constant:
    @IBOutlet weak var imageViewConstrain: NSLayoutConstraint!
    @IBOutlet weak var mainViewConstrain: NSLayoutConstraint!
    
    //Button:
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        windStule()
        // Do any additional setup after loading the view.
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(imageTap)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        
        nameRecommendation.delegate = self
        shortDescription.delegate = self
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func windStule(){
        nameRecommendation.attributedPlaceholder = NSAttributedString(string: "НАЗВАНИЕ МЕРОПРИЯТИЯ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        shortDescription.attributedPlaceholder = NSAttributedString(string: "КРАТКОЕ СОДЕРЖАНИЕ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        mainCardView.layer.cornerRadius = 15
        mainCardView.clipsToBounds = true
        
        addImage.tintColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        addImage.layer.cornerRadius = addImage.frame.size.width / 2
        addImage.clipsToBounds = true
        
        imageViewConstrain.constant = (imageView.frame.width / 2) - 50
        
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.cornerRadius = 20
        
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.layer.cornerRadius = 20
        
        mainViewConstrain.constant =  (imageViewConstrain.constant + 100)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if( textField.restorationIdentifier == "textFieldName"){
            nameRecommendationLabel.text = textField.text
        }else{
            shortDescriptionLabel.text = textField.text
        }
    }
    
    @IBAction func changeButtonAction(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func openImagePicker(_ sender:Any) {
           // Open Image Picker
           self.present(imagePicker, animated: true, completion: nil)
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

extension CreatLittleCard: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let a = self.resizeImage(image: pickedImage, newWidth: view.frame.size.width)
            self.image.image = a
            let imageData = image.image!.pngData()!
            imageBigBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
          
            //self.image.image = pickedImage
            //let imageData   = image.image!.pngData()!
            //imageBase64   = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
