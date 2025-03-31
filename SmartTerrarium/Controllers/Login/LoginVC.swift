//
//  LoginVC.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 03/11/2024.
//

import Foundation
import UIKit

class LoginVC: UIViewController{
    
    let scrollView  = UIScrollView()
    let contentView = UIView()
    let loginFormView = UIView()
    
    let loginImageView = UIImageView()
    let usernameIcon = UIImageView()
    let passwordIcon = UIImageView()
    
    let loginLbl = CustomLabel1()
    let registerLbl = CustomLabel1()
    
    let usernameTf = UsernameTextField()
    let passwordTf = PasswordTextField()
    let forgetPasswordBtn = EButton()
    
    let signUpBtn = EButton()
    
    lazy var loginBtn = ChangeMobileButton(title: Strings.signin.rawValue) { [weak self] in
        
        //do something here
        guard let self else { return }
        self.loginSuccessful()
        //self.loginBtnClicked()
        
    }
    
    private func loginSuccessful(){
        let mainTabBarController = MainTabBarVC()
        navigationController?.setViewControllers([mainTabBarController], animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
                self.additionalSafeAreaInsets = .zero
        }
        configVC()
        configScrollView()
        configLoginImage()
        configLoginAndRegisteryLabel()
        configLoginFormView()
        //configForgetBtn()
        configLoginAndSignUpBtn()
        
    }
    
    private func configVC(){
        view.backgroundColor = .systemBackground
        scrollView.frame = view.bounds
        contentView.addSubViews(loginImageView, loginLbl, loginFormView, forgetPasswordBtn, loginBtn, registerLbl, signUpBtn)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(to: view)
        scrollView.contentInsetAdjustmentBehavior = .never
        
        contentView.pinToEdges(to: scrollView)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
    private func configLoginImage() {
            loginImageView.contentMode  = .scaleAspectFit
            loginImageView.translatesAutoresizingMaskIntoConstraints = false
            loginImageView.image = UIImage(named: "login_logo")
            
            NSLayoutConstraint.activate([
                loginImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
                loginImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
                loginImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
                loginImageView.heightAnchor.constraint(equalToConstant: 400),
            ])
        }
    
    private func configLoginAndRegisteryLabel() {
        loginLbl.text = "Login"
        loginLbl.font = .systemFont(ofSize: 40, weight: .bold)
        
        registerLbl.text = "New user? Sign up now!"
        registerLbl.font = .systemFont(ofSize: 22, weight: .regular)

        NSLayoutConstraint.activate([
            loginLbl.topAnchor.constraint(equalTo: loginImageView.bottomAnchor, constant: 10),
            loginLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loginLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loginLbl.heightAnchor.constraint(equalToConstant: 50),
            
            
            registerLbl.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
            registerLbl.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        if DeviceTypes.isiPhoneSE {
            registerLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90).isActive = true
            signUpBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90).isActive = true
        } else if DeviceTypes.isiPhoneMini {
            registerLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80).isActive = true
            signUpBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80).isActive = true
        } else if DeviceTypes.isiPhone11 {
            registerLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90).isActive = true
            signUpBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90).isActive = true
        } else if DeviceTypes.isiPhonePro {
            registerLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80).isActive = true
            signUpBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90).isActive = true
        } else if DeviceTypes.isiPhone14Pro {
            registerLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90).isActive = true
            signUpBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80).isActive = true
        } else {
            registerLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 120).isActive = true
            signUpBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100).isActive = true
        }
     
    
    }


    private func configLoginFormView() {
        usernameTf.autocapitalizationType = .none
        
        loginFormView.translatesAutoresizingMaskIntoConstraints = false
        loginFormView.layer.cornerRadius = 10
        loginFormView.backgroundColor = .secondarySystemBackground
        
        usernameIcon.translatesAutoresizingMaskIntoConstraints = false
        usernameIcon.image = Images.usernameIcon
        usernameIcon.contentMode = .scaleAspectFill
        
        passwordIcon.translatesAutoresizingMaskIntoConstraints = false
        passwordIcon.image = Images.passwordIcon
        passwordIcon.contentMode = .scaleAspectFill
        
        loginFormView.addSubViews(usernameIcon, usernameTf, passwordIcon, passwordTf)
        
        //add line under textfields
        usernameTf.addLine(position: .bottom, color: .label, width: 0.5)
        passwordTf.addLine(position: .bottom, color: .label, width: 0.4)
        
        NSLayoutConstraint.activate([
            
            loginFormView.topAnchor.constraint(equalTo: loginLbl.bottomAnchor, constant: 10),
            loginFormView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            loginFormView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            loginFormView.heightAnchor.constraint(equalToConstant: 130),
            
            usernameIcon.topAnchor.constraint(equalTo: loginFormView.topAnchor, constant: 20),
            usernameIcon.leadingAnchor.constraint(equalTo: loginFormView.leadingAnchor, constant: 10),
            usernameIcon.widthAnchor.constraint(equalToConstant: 35),
            usernameIcon.heightAnchor.constraint(equalToConstant: 35),
            
            usernameTf.bottomAnchor.constraint(equalTo: usernameIcon.bottomAnchor),
            usernameTf.leadingAnchor.constraint(equalTo: usernameIcon.trailingAnchor, constant: 6),
            usernameTf.trailingAnchor.constraint(equalTo: loginFormView.trailingAnchor, constant: -20),
            usernameTf.heightAnchor.constraint(equalToConstant: 50),
            
            passwordIcon.topAnchor.constraint(equalTo: usernameIcon.bottomAnchor, constant: 20),
            passwordIcon.leadingAnchor.constraint(equalTo: loginFormView.leadingAnchor, constant: 10),
            passwordIcon.widthAnchor.constraint(equalToConstant: 35),
            passwordIcon.heightAnchor.constraint(equalToConstant: 35),
            
            passwordTf.bottomAnchor.constraint(equalTo: passwordIcon.bottomAnchor),
            passwordTf.leadingAnchor.constraint(equalTo: passwordIcon.trailingAnchor, constant: 6),
            passwordTf.trailingAnchor.constraint(equalTo: loginFormView.trailingAnchor, constant: -20),
            passwordTf.heightAnchor.constraint(equalToConstant: 50),
            
        ])

        
    }
    private func configLoginAndSignUpBtn() {
            loginBtn.backgroundColor = UIColor.blue
            
            NSLayoutConstraint.activate([
                loginBtn.topAnchor.constraint(equalTo: loginFormView.bottomAnchor, constant: 20),
                loginBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90),
                loginBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
                loginBtn.heightAnchor.constraint(equalToConstant: 50),
                
                
                signUpBtn.topAnchor.constraint(equalTo: registerLbl.bottomAnchor, constant: -22),
                            signUpBtn.leadingAnchor.constraint(equalTo: registerLbl.trailingAnchor, constant: 6),
                            signUpBtn.heightAnchor.constraint(equalTo: registerLbl.heightAnchor)
                
            ])
    }
}
