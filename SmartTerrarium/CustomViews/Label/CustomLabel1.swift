//
//  CustomLabel1.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 03/11/2024.
//

import Foundation
import UIKit

class CustomLabel1: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configlbl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat , textWeight: UIFont.Weight) {
        self.init(frame: .zero)
        self.textAlignment      = textAlignment
        self.font               = UIFont.systemFont(ofSize: fontSize, weight: textWeight)
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat , textWeight: UIFont.Weight, text: String?) {
        self.init(frame: .zero)
        self.textAlignment      = textAlignment
        self.font               = UIFont.systemFont(ofSize: fontSize, weight: textWeight)
        self.text               = text
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font           = UIFont(name: "Helvetica Neue", size: fontSize)
    }
    
    private func configlbl(){
        translatesAutoresizingMaskIntoConstraints = false
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byWordWrapping
        
    }

}


