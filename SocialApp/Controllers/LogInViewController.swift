//
//  ViewController.swift
//  SocialApp
//
//  Created by Иван Казанцев on 12.01.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
//OUTLETS_&_ACTIONS
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var socialAppLabel: UILabel?
    @IBOutlet weak var loginTextView: UITextField?
    @IBOutlet weak var passwordTextView: UITextField?
    @IBOutlet weak var logInButton: UIButton?
    @IBOutlet weak var textFieldsIsEmptyLabel: UILabel?
    @IBAction func logInButton(_ sender: UIButton) {
        
    }
    @IBOutlet weak var loaderCirclesView: LoaderCirclesView!
    
//OUTLETS_&_ACTIONS
//----------------------------------------------------------------------------------------------------------
//VARS_&_CONSTS
    private var keyboardShown = false
//VARS_&_CONSTS
//----------------------------------------------------------------------------------------------------------
//FUNCTIONS
    /// Обрабатываем момент появления клавиатуры, достаем из уведомления данные о том, какой будет финальный размер клавиатуры и добавляем отступы в скроллвью снизу. Перед эти проверяем не поднята ли уже клавиатура, так как этот метод может вызываться дважды (баг)
    @objc private func keyboardWillShow(notification: Notification) {
        
        guard !keyboardShown else { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else {
            return
        }
        scrollView?.contentInset.bottom += keyboardFrame.height
        keyboardShown = true
        
    }
    //-------------
    /// Все то же самое, что и с появлением клавиатуры, только отступ уменьшаем
    @objc private func keyboardWillHide(notification: Notification) {
        
        guard keyboardShown else { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else {
            return
        }
        scrollView?.contentInset.bottom -= keyboardFrame.height
        keyboardShown = false
        
    }
    //-------------
    //функция, которая выключает клавиатуру при нажатии на экран
    @objc func hideKeyboard() {
        
        self.scrollView?.endEditing(true)
        
    }
    //-------------
    /// Добавление слушателей на появление/ скрытие клавиатуры. Регистрируем контроллер в качестве обозревателя и передаем какой метод должен быть вызван(селектор) по наступлении события, передаем name в качетсве имени события, хоторое хотим слушать, у нас это появление и скрытие клавиатуры
    private func addKeyboardObservers() {
        
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    // Второе — когда она пропадает
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    //-------------
    /// Добавляем обработку нажатия на экран для скрытия клавиатуры. Данный метод работает только с passowrdTextField, если клавиатура поднята для ввода в него, нужно сделать то же самое и для поля ввода логина
    private func addTapGestureRecognizer() {
        
        let recognizerPasswordTextView = UITapGestureRecognizer(target: passwordTextView, action: #selector(resignFirstResponder))
        view.addGestureRecognizer(recognizerPasswordTextView)
        let recognizerLoginTextView = UITapGestureRecognizer(target: loginTextView, action: #selector(resignFirstResponder))
        view.addGestureRecognizer(recognizerLoginTextView)
        let recognizerHideKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(recognizerHideKeyboard)

    }
    
    func textFieldAnimation() {
    
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: loginTextView!.center.x - 10, y: loginTextView!.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: loginTextView!.center.x + 10, y: loginTextView!.center.y))
        animation.fromValue = NSValue(cgPoint: CGPoint(x: passwordTextView!.center.x - 10, y:  passwordTextView!.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: passwordTextView!.center.x + 10, y: passwordTextView!.center.y))
        loginTextView!.layer.add(animation, forKey: "position")
        passwordTextView!.layer.add(animation, forKey: "position")
        
    }
    
    func checkLogIn() -> Bool {
        
        if let login = loginTextView?.text,
           let password = passwordTextView?.text {
        if login == "moran8" && password == "12345" {
            textFieldsIsEmptyLabel?.text = "Успешная авторизация"
            performSegue(withIdentifier: "loggedIn", sender: UIButton())
            return true
        } else {
            if loginTextView!.text!.isEmpty && passwordTextView!.text!.isEmpty {
                emptyTextfieldsWhenLogIn()
                return false
            }
            failForLogIn()
            textFieldAnimation()
            return false
        }
        }
        return false

    }
    
    func failForLogIn() {
        
        let alert = UIAlertController(title: "Ошибка", message: "Неверное сочетание логиина и пароля", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            print("Ok clicked")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func emptyTextfieldsWhenLogIn() {
        
        let alert = UIAlertController(title: "Ошибка", message: "Не введены значения", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) {_ in print("Ok clicked")}
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if checkLogIn() {
            return true
        } else {
            if loginTextView!.text!.isEmpty && passwordTextView!.text!.isEmpty {
                emptyTextfieldsWhenLogIn()
                return false
            }
            failForLogIn()
            textFieldAnimation()
            return false
        }
        
    }
//FUNCTIONS
//-----------------------------------------------------------------------------------------------------------
//SCREEN CYCLES
    override func viewDidLoad() {
        
        super.viewDidLoad()
        addKeyboardObservers()
        addTapGestureRecognizer()
        loaderCirclesView.animateLoader()
        //скругление кнопки
        let path = UIBezierPath()
        if logInButton != nil {
            path.addArc(withCenter: CGPoint(x: logInButton!.bounds.width/2, y: logInButton!.bounds.height/2), radius: logInButton!.bounds.width/2, startAngle: 0, endAngle: 360, clockwise: true)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        logInButton!.layer.mask = maskLayer
        }
        //закругление углов лейбла
        socialAppLabel!.clipsToBounds = true
        socialAppLabel!.layer.cornerRadius = 20
        
    }
    //-------------
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
            
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
//SCREEN CYCLES
//----------------------------------------------------------------------------------------------------------
}

