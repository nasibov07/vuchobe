//
//  Registration.swift
//  VUCHOBE 1.0
//
//  Created by Rovshan on 23/08/2019.
//  Copyright © 2019 Rovshan. All rights reserved.
//

import UIKit
//Oкно регистрации
class Registration: UIViewController {
   
    let urlAddress = MyURLAddress.shared
    
    @IBOutlet weak var windowsView: UIScrollView!
    
    //текстовые поля
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTwoTextField: UITextField!
    
    //окна
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var userNameTextFieldView: UIView!
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var passwordTwoTextFieldView: UIView!
    
    //изображения
    
    @IBOutlet weak var eyeIconPassword: UIImageView!
    @IBOutlet weak var eyeIconPasswordTwo: UIImageView!
    @IBOutlet weak var emailImageIcon: UIImageView!
    @IBOutlet weak var userNameImageIcon: UIImageView!
    @IBOutlet weak var kayImageIcon: UIImageView!
    @IBOutlet weak var kayTwoImageIcon: UIImageView!
    @IBOutlet weak var internetImageIcon: UIImageView!
    @IBOutlet weak var docImageIcon: UIImageView!
    
    //кнопка
    @IBOutlet weak var enterStyleButton: UIButton!
    @IBOutlet weak var backStyleButton: UIButton!
    
    //ошибка
    @IBOutlet weak var errorTextField: UILabel!
    
    //переключатель изображения "Проверка интернета"
    var internetBool: Bool = false
    
    //var reachability проверка интернета
    var reachability: Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reqStyleWindow()
        registerForKeyboardNotifications()
        
    }
    
    //Метод дизайна окон
    func reqStyleWindow(){
        //силь кнопка войти
        enterStyleButton.layer.borderWidth = 1
        enterStyleButton.layer.borderColor = UIColor.white.cgColor
        enterStyleButton.layer.cornerRadius = 20
        
        //силь кнопка регистрация
//        backStyleButton.layer.borderWidth = 1
//        backStyleButton.layer.borderColor = UIColor.white.cgColor
//        backStyleButton.layer.cornerRadius = 20
        
        //Цвет иконки
        emailImageIcon.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        kayImageIcon.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        kayTwoImageIcon.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        internetImageIcon.tintColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        userNameImageIcon.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        docImageIcon.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        eyeIconPassword.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
         eyeIconPasswordTwo.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        //Placeholder
        emailTextField.attributedPlaceholder = NSAttributedString(string: "ВВЕДИТЕ ПОЧТУ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "ВВЕДИТЕ ПАРОЛЬ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTwoTextField.attributedPlaceholder = NSAttributedString(string: "ВВЕДИТЕ ПАРОЛЬ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "ВВЕДИТЕ ИМЯ ПОЛЬЗОВАТЕЛЯ",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    //кнопка регисрации пользователя
    @IBAction func enterActionButton(_ sender: Any) {
        
        emailTextFieldView.layer.backgroundColor = UIColor.gray.cgColor
        userNameTextFieldView.layer.backgroundColor = UIColor.gray.cgColor
        passwordTextFieldView.layer.backgroundColor = UIColor.gray.cgColor
        passwordTwoTextFieldView.layer.backgroundColor = UIColor.gray.cgColor
        testInternet()

        let username = userNameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let passwordTwo = passwordTextField.text
        var bool = true
        
        //проверка и вывод ошибки
        if(internetBool != true){
            if((username == "") || (email == "") || (password == "") || (passwordTwo == "")){
                errorTextField.text = "Заполните все поля"
                emailTextFieldView.layer.backgroundColor = UIColor.red.cgColor
                userNameTextFieldView.layer.backgroundColor = UIColor.red.cgColor
                passwordTextFieldView.layer.backgroundColor = UIColor.red.cgColor
                passwordTwoTextFieldView.layer.backgroundColor = UIColor.red.cgColor
                bool = false
            }
            //запрос на авторизацию
            if(bool == true){
                registrationFunc(username: username!, password: password!, email: email!)
            }
        }
    }
    
    //POST запрос
    func registrationFunc(username: String, password: String, email: String){
        let json: [String: Any] = [
            "username": "\(username)",
            "password": "\(password)",
            "email":    "\(email)"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: "\(urlAddress.UrlForRegistration)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        // Устанавливаем тело в запросе
        request.httpBody = jsonData
        
        let task = session.dataTask(with: request){
            data, response, error in guard let _ = data, error == nil
                else{
                    let alert = UIAlertController(title: "Ошибка", message: "Произошла не предвиденная ошибка", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in }))
                    self.present(alert, animated: true, completion: nil)
                    print(error as Any)
                    return
            }
            let a = String(data: data!, encoding: .utf8)
            print("data:", a as Any )
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Регистрация", message: "Вы зарегистрированы!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default: do {
                        self.backMove()
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
        };task.resume()
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
                errorTextField.text = "Интернет не доступен"
            }
        }
    }
    
    //кнопка назад
    @IBAction func backActionButton(_ sender: Any) {
        backMove()
    }
    
    func backMove(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    //Пользоватальское соглашение
    @IBAction func docActionButton(_ sender: Any) {
    }
    
    @IBAction func showKeyOne(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func showKeyTwo(_ sender: Any) {
        passwordTwoTextField.isSecureTextEntry = !passwordTwoTextField.isSecureTextEntry
    }
    
    
    //Работа с клавиатурой:----------------------------начало

    
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
        windowsView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    @objc  func kbWillHide() {
        windowsView.contentOffset = CGPoint(x: 0, y: 0)
    }
    //Работа с клавиатурой:----------------------------конец
}
