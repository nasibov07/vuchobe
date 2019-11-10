//
//  ViewController.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 21/08/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController, UITextFieldDelegate {

    var myTimeTable  = [SingleTon.shared]
    let urlAddress = MyURLAddress.shared
    var m = [Weak]()
    //MyTokan
    var userData = UserData.shared
    @IBOutlet weak var windowsView:         UIScrollView!
    //текстовые поля
    @IBOutlet weak var emailTextField:      UITextField!
    @IBOutlet weak var passwordTextField:   UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //изображения
    @IBOutlet weak var emailImageIcon:      UIImageView!
    @IBOutlet weak var kayImageIcon:        UIImageView!
    @IBOutlet weak var questionImageIcon:   UIImageView!
    @IBOutlet weak var internetImageIcon:   UIImageView!
    
    //кнопка
    @IBOutlet weak var enterStyleButton:    UIButton!
    @IBOutlet weak var reqStyleButton:      UIButton!
    
    //линии под текстовыми полями
    @IBOutlet weak var emailViewLine:       UIView!
    @IBOutlet weak var passwordViewLine:    UIView!
    
    //вывод ошибки
    @IBOutlet weak var errorTextLable: UILabel!
    
    //переключатель изображения "Проверка интернета"
    var internetBool: Bool = false
    //var reachability: Reachability?
    var reachability: Reachability?
    
    //Гавная функция swift
    override func viewDidLoad() {
        super.viewDidLoad()
        //действие: запуск стилей
        authStyleWindow()
        //действие: запуск клавиатуры
        registerForKeyboardNotifications()

    }
    //парсинг jwt
    func getJwtBodyString(tokenstr: String) -> NSString {
        
        let segments = tokenstr.components(separatedBy: ".")
        var base64String = segments[1]
        //print("\(base64String)")
        let requiredLength = Int(4 * ceil(Float(base64String.count) / 4.0))
        let nbrPaddings = requiredLength - base64String.count
        if nbrPaddings > 0 {
            let padding = String().padding(toLength: nbrPaddings, withPad: "=", startingAt: 0)
            base64String = base64String.appending(padding)
        }
        base64String = base64String.replacingOccurrences(of: "-", with: "+")
        base64String = base64String.replacingOccurrences(of: "_", with: "/")
        let decodedData = Data(base64Encoded: base64String, options: Data.Base64DecodingOptions(rawValue: UInt(0)))
        //  var decodedString : String = String(decodedData : nsdata as Data, encoding: String.Encoding.utf8)
        
        let base64Decoded: String = String(data: decodedData! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        print("\(base64Decoded)")
        return base64String as NSString
    }
    
    //действие: вход в приложение
    @IBAction func enterActionButton(_ sender: Any) {
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
//                          vc.modalPresentationStyle = .fullScreen
//                          self.present(vc, animated: false, completion: nil)
//                          self.activityIndicator.isHidden = !self.activityIndicator.isHidden
//                          self.navigationController?.pushViewController(vc, animated: true)
        
        
        emailViewLine.layer.backgroundColor = UIColor.gray.cgColor
        passwordViewLine.layer.backgroundColor = UIColor.gray.cgColor
        //проверка интернета
        testInternet()

        let username = emailTextField.text
        let password = passwordTextField.text
        var bool = true

        //проверка и вывод ошибки
        if(internetBool != true){
            if((username == "") && (password == "")){
                errorTextLable.text = "Введите почту и пароль"
                emailViewLine.layer.backgroundColor = UIColor.red.cgColor
                passwordViewLine.layer.backgroundColor = UIColor.red.cgColor
                bool = false
            }else{
                if(username == ""){
                    bool = false
                    emailViewLine.layer.backgroundColor = UIColor.red.cgColor
                    errorTextLable.text = "Введите почту"
                }
                if(password == ""){
                    bool = false
                    passwordViewLine.layer.backgroundColor = UIColor.red.cgColor
                    errorTextLable.text = "Введите пароль"
                }
            }//запрос на авторизацию
            if(bool == true){

                activityIndicator.isHidden = !activityIndicator.isHidden
                activityIndicator.startAnimating()
                enterRequestFunc(username: username!, password: password!)
            }
        }
    }

    //показать пароль
    @IBAction func showActionPassword(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    //действие: регистрация в приложении
    @IBAction func reqActionButton(_ sender: Any) {
    }
    
    //проверка интернета
    func testInternet(){
        self.reachability = try? Reachability.init()
        
        if((self.reachability!.connection) != .unavailable){
            if(internetBool == true){
                internetImageIcon.isHidden = !internetImageIcon.isHidden
                internetBool = false
            }
        }else{
            if(internetBool == false){
                internetImageIcon.isHidden = !internetImageIcon.isHidden
                
                internetBool = true
                errorTextLable.text = "Интернет не доступен"
            }
        }
    }
    
    //функция отвечающая за стиль
    func authStyleWindow(){
        activityIndicator.isHidden = !activityIndicator.isHidden
        //силь кнопка войти
        enterStyleButton.layer.borderWidth = 1
        //голубой цвет
        //enterStyleButton.layer.backgroundColor = UIColor.init(red: 0/255, green: 150/255, blue: 255/255, alpha: 1.0).cgColor
        enterStyleButton.layer.borderColor = UIColor.white.cgColor
        enterStyleButton.layer.cornerRadius = 20
        
        //силь кнопка регистрация
        reqStyleButton.layer.borderWidth = 1
        reqStyleButton.layer.borderColor = UIColor.white.cgColor
        reqStyleButton.layer.cornerRadius = 20
        
        //Цвет иконки
        emailImageIcon.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        kayImageIcon.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        questionImageIcon.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        internetImageIcon.tintColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        
        //Placeholder
        emailTextField.attributedPlaceholder = NSAttributedString(string: "ВВЕДИТЕ ПОЧТУ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "ВВЕДИТЕ ПАРОЛЬ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    //функция для авторизации
    func enterRequestFunc(username: String, password: String){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let json: [String: Any] = ["email": "\(username)",
                                   "password": "\(password)"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: "\(urlAddress.UrlForAuthorization)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
            
            if(data != nil){
                
            }else{
                self.showMiniWindows(titleText: "Информация ", MessageText: "Токен с сервера не был получен.")
                self.activityIndicator.isHidden = !self.activityIndicator.isHidden
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200
            {
                switch httpStatus.statusCode{
                case 403: do {
                    DispatchQueue.main.async {
                        self.errorTextLable.text = "Почта или пароль введены не верно"
                        self.activityIndicator.isHidden = !self.activityIndicator.isHidden
                    }
                    }
                default : do {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    self.activityIndicator.isHidden = !self.activityIndicator.isHidden
                    }
                }
            }else{
                //let inform = String(data: data!, encoding: .utf8)
               
                    print("Good")
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)
                        self.activityIndicator.isHidden = !self.activityIndicator.isHidden
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                
            }
            
            if let httpResponse = response as? HTTPURLResponse
            {
                if let mySetCookies = httpResponse.allHeaderFields["Authorization"] as? String{
                    self.userData.tokan = mySetCookies
                    let tokenString = self.getJwtBodyString(tokenstr: mySetCookies)
                    print(tokenString)
                    
                }
            }
        };task.resume()
    }
    
    func showMiniWindows(titleText: String, MessageText: String){
        let alert = UIAlertController(title: titleText, message: MessageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default: do {
                
                }
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            @unknown default:
                print("")
            }}))
        self.present(alert, animated: true, completion: nil)
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
        UIView.animate(withDuration: 0.3, animations: {
            let userInfo = notification.userInfo
                   let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            self.windowsView.contentOffset = CGPoint(x: 0, y: 100)
        })
    }
    
    @objc  func kbWillHide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.windowsView.contentOffset = CGPoint(x: 0, y: 0)
        })
    }
    //Работа с клавиатурой:----------------------------конец
    
}

