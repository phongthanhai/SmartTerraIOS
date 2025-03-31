//
//  PasswordTextField.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 03/11/2024.
//

import Foundation
import UIKit

class PasswordTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configpass()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configpass() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textContentType     = .password
        isSecureTextEntry   = true
        
        layer.cornerRadius      = 5
        
        textColor               = .label
        tintColor               = .label
        
        textAlignment           = .left
        font                    = UIFont.systemFont(ofSize: 17)
        minimumFontSize         = 17
        
        backgroundColor         = .clear
        autocorrectionType      = .no
        returnKeyType           = .go
        clearButtonMode         = .whileEditing
        placeholder             = "•••••••••••••"
        
    }

}

