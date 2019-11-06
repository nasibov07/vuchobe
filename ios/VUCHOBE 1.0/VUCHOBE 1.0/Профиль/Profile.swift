//
//  Profile.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 03/09/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit

class Profile: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let arrayUniver = ["СамГУПС","СГАУ","СУ","СамГТУ"]
    //let arrayFack = ["СИТ","ПСЛ","МСИ","ГИС"]
    let arrayQrup = ["ИСТБ-51","ИСТБ-52","ИСТБ-53","ИСТБ-54"]
    var resultUniversity = [ModelClassContent]()
    var resultFaculty = [ModelClassContent]()
    var resultQroup = [ModelClassContent]()
    var urlAddress = MyURLAddress.shared
    
    var imagePicker: UIImagePickerController!
    var imageBase64: String = ""
    
    //ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    //baseButton
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //image:
    @IBOutlet weak var profileImage: UIImageView!//Изображение профиля
    @IBOutlet weak var plusImage: UIImageView!
    
    //textField
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordOne: UITextField!
    @IBOutlet weak var passwordTwo: UITextField!
    
    //View:
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var surnameView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var matherView: UIView!
    @IBOutlet weak var passwordOneView: UIView!
    @IBOutlet weak var passwordTwoView: UIView!
    
    //comboBox:-1
    @IBOutlet weak var oneComboBoxView: UIView!
    @IBOutlet weak var oneComboBoxLabel: UILabel!
    @IBOutlet weak var oneComboBoxButtonOutlet: UIButton!
    var oneComboBoxButtonBool: Bool = false
    @IBOutlet weak var oneComboBoxTableView: UIView!
    @IBOutlet weak var oneComboBoxTable: UITableView!
    @IBOutlet weak var oneComboBoxConstraint: NSLayoutConstraint!
    @IBOutlet weak var oneComboBoxImage: UIImageView!
    var oneComboBoxConstraintValue: Int = 0
    
    @IBAction func oneComboBoxButtonAction(_ sender: Any) {
        print("1")
        if(oneComboBoxButtonBool != true){
            oneComboBoxConstraint.constant = CGFloat(arrayUniver.count * 40)
            oneComboBoxButtonBool = true
        }else{
            oneComboBoxConstraint.constant = 0
            oneComboBoxButtonBool = false
        }
    }
    
    //comboBox:-2
    @IBOutlet weak var twoComboBoxView: UIView!
    @IBOutlet weak var twoComboBoxImage: UIImageView!
    @IBOutlet weak var twoComboBoxLabel: UILabel!
    @IBOutlet weak var twoComboBoxButtonOutlet: UIButton!
    @IBOutlet weak var twoComboBoxTableView: UIView!
    @IBOutlet weak var twoComboBoxTable: UITableView!
    @IBOutlet weak var threeComboBoxImage: UIImageView!
    @IBOutlet weak var twoComboBoxConstraint: NSLayoutConstraint!
    var twoComboBoxButtonBool: Bool = false
    var twoComboBoxConstraintValue: Int = 0
    
    @IBAction func twoComboBoxButtonAction(_ sender: Any) {
        print("2")
        if(twoComboBoxButtonBool != true){
            twoComboBoxConstraint.constant = CGFloat(twoComboBoxConstraintValue * 40)
            twoComboBoxButtonBool = true
        }else{
            twoComboBoxConstraint.constant = 0
            twoComboBoxButtonBool = false
        }
    }
    
    //comboBox:-3
    @IBOutlet weak var threeComboBoxView: UIView!
    @IBOutlet weak var threeComboBoxLabel: UILabel!
    @IBOutlet weak var threeComboBoxButtonOutlet: UIButton!
    @IBOutlet weak var threeComboBoxTableView: UIView!
    @IBOutlet weak var threeComboBoxTable: UITableView!
    @IBOutlet weak var threeComboBoxConstraint: NSLayoutConstraint!
    var threeComboBoxButtonBool: Bool = false
    var threeComboBoxConstraintValue: Int = 0
    
    @IBAction func threeComboBoxButtonAction(_ sender: Any) {
        print("3")
        if(threeComboBoxButtonBool != true){
            threeComboBoxConstraint.constant = CGFloat(arrayUniver.count * 40)
            threeComboBoxButtonBool = true
        }else{
            threeComboBoxConstraint.constant = 0
            threeComboBoxButtonBool = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        windowViewStyle()
        requestForGetting(urlAddress: urlAddress.UrlForGettingUniversityName, body: "?size=10&page=0&sort=fullName,ASC", tableView: twoComboBoxTable)
        
        // Do any additional setup after loading the view.
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(imageTap)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = (self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        
        
        //Временные поля
        usernameTextField.text = "Rovshan34"
        surnameTextField.text = "Насибов"
        nameTextField.text = "Ровшан"
        secondNameTextField.text = "Эльчин оглы"
        emailTextField.text = "rovsen1993@gmail.com"
        
        oneComboBoxLabel.text = "СамГУПС"
        twoComboBoxLabel.text = "СИТ"
        threeComboBoxLabel.text = "ИСТм-91"
        
        
    }
    
    @objc func openImagePicker(_ sender:Any) {
              // Open Image Picker
              self.present(imagePicker, animated: true, completion: nil)
          }
    
    //MARK: tableView number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case oneComboBoxTable: do {
            return arrayUniver.count
        }
        case twoComboBoxTable: do {
             return resultFaculty.count
            }
        case threeComboBoxTable: do {
             return arrayQrup.count
            }
        default:
            print("ERROR")
            return  0
        }
    }
    
    //MARK: tableView Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == oneComboBoxTable){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UniversityCell") as? UniversityCell else{
                return UITableViewCell()
            }
            cell.myTextLabel?.text = arrayUniver[indexPath.row]
            return cell
        }else{
            if(tableView == twoComboBoxTable){
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "FacultyCell") as? FacultyCell else{
                    return UITableViewCell()
                }
                cell.myTextLabel?.text = resultFaculty[indexPath.row].shortName
                return cell
            }else{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "QrupCell") as? QrupCell else{
                    return UITableViewCell()
                }
                cell.myTextLabel?.text = arrayQrup[indexPath.row]
                return cell
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        switch tableView {
        case oneComboBoxTable: do {
            oneComboBoxLabel.text = arrayUniver[indexPath.row]
            oneComboBoxConstraint.constant = 0
            oneComboBoxButtonBool = false
            }
        case twoComboBoxTable: do {
            twoComboBoxLabel.text = resultFaculty[indexPath.row].shortName
            twoComboBoxConstraint.constant = 0
            twoComboBoxButtonBool = false
        }
        case threeComboBoxTable: do {
            threeComboBoxLabel.text = arrayQrup[indexPath.row]
            threeComboBoxConstraint.constant = 0
            threeComboBoxButtonBool = false
        }
        default:
            print("Error did select!")
        }
        
    }
    //MARK: Style
    func windowViewStyle(){
        oneComboBoxView.layer.borderWidth = 1
        oneComboBoxView.layer.borderColor = UIColor.white.cgColor
        twoComboBoxView.layer.borderWidth = 1
        twoComboBoxView.layer.borderColor = UIColor.white.cgColor
        threeComboBoxView.layer.borderWidth = 1
        threeComboBoxView.layer.borderColor = UIColor.white.cgColor
        
        oneComboBoxConstraint.constant = 0
        twoComboBoxConstraint.constant = 0
        threeComboBoxConstraint.constant = 0
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        plusImage.tintColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0)
        plusImage.layer.cornerRadius = plusImage.frame.size.width / 2
        plusImage.clipsToBounds = true
        
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "ИМЯ ПОЛЬЗОВАТЕЛЯ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        surnameTextField.attributedPlaceholder = NSAttributedString(string: "ФАМИЛИТЯ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nameTextField.attributedPlaceholder = NSAttributedString(string: "ИМЯ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        secondNameTextField.attributedPlaceholder = NSAttributedString(string: "ОТЧЕСТВО",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "ПОЧТА",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        passwordOne.attributedPlaceholder = NSAttributedString(string: "ПАРОЛЬ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTwo.attributedPlaceholder = NSAttributedString(string: "ПАРОЛЬ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        oneComboBoxTableView.layer.borderWidth = 1
        oneComboBoxTableView.layer.borderColor   = UIColor.white.cgColor
        oneComboBoxImage.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        twoComboBoxTableView.layer.borderWidth = 1
        twoComboBoxTableView.layer.borderColor   = UIColor.white.cgColor
        twoComboBoxImage.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        threeComboBoxTableView.layer.borderWidth = 1
        threeComboBoxTableView.layer.borderColor   = UIColor.white.cgColor
        threeComboBoxImage.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.cornerRadius = 20
    }
    
    //MARK: requestForGetting
    func requestForGetting(urlAddress: String, body: String, tableView: UITableView){
        let url : NSString = (urlAddress + body) as NSString
        let urlStr : NSString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! as NSString
        let searchURL : URL = URL(string: urlStr as String)!
    
        let session = URLSession.shared
        session.dataTask(with: searchURL) { (data, response, error) in
            if let data = data {
                do{
                    let decoder = JSONDecoder()
                    let downloadedResult = try decoder.decode(ModelClass.self, from: data)
                    
                    
                    let dataStreing = String(data: data, encoding: .utf8)
                    
                    print(dataStreing as Any)
                    DispatchQueue.main.async {
                        if(downloadedResult.totalElements != 0){
                            switch tableView {
                            case self.oneComboBoxTable: do{
                                self.oneComboBoxConstraint.constant = CGFloat(downloadedResult.totalElements! * 40)
                                self.oneComboBoxTable.reloadData()
                            }
                            case self.twoComboBoxTable: do{
                                self.resultFaculty = downloadedResult.content!
                                self.twoComboBoxConstraintValue = downloadedResult.totalElements!
                                self.twoComboBoxTable.reloadData()
                                
                            }
                            case self.threeComboBoxTable: do{
                                self.threeComboBoxConstraint.constant = CGFloat(downloadedResult.totalElements! * 40)
                                self.threeComboBoxTable.reloadData()
                            }
                            default: print("Error")
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    
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
        UIView.animate(withDuration: 0.3, animations: {
            let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            self.scrollView.contentOffset = CGPoint(x: 0, y: 150)
        })
       }
       
       @objc  func kbWillHide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        })
       }
       //Работа с клавиатурой:----------------------------конец
       
    
}

extension Profile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImage.image = pickedImage
            let imageData = profileImage.image!.pngData()!
            imageBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
