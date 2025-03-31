//
//  HumidityCard.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 13/11/2024.
//

import Foundation
import UIKit

class HumidityCard: UIView {
    
    let humidityLbl  = CustomLabel1(textAlignment: .center, fontSize: 24, textWeight: .semibold, text: "Humidity")
    let valueLbl     = CustomLabel1(textAlignment: .center, fontSize: 24, textWeight: .regular, text: "")
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCard()
        setupGradientLayer()
        configLabels()
        startVaporizingEffect()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(gradientColors: [UIColor]) {
        self.init(frame: .zero)
        setupGradientLayer(colors: gradientColors)
    }
    
    private func configCard() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    private func setupGradientLayer(colors: [UIColor] = [UIColor.systemBlue, UIColor.systemTeal, UIColor.cyan]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configLabels() {
        humidityLbl.textColor   = .white
        valueLbl.textColor      = .white
        valueLbl.text           = "60%" // Default humidity value
        
        addSubViews(humidityLbl, valueLbl)
        
        NSLayoutConstraint.activate([
            humidityLbl.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            humidityLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLbl.topAnchor.constraint(equalTo: humidityLbl.bottomAnchor, constant: 16),
            valueLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    /**
            Function to set new value for humidity
     */
    func setHumidity(_ humidity: String) {
        valueLbl.text = humidity
    }
    
    // Vaporizing effect: pulse between two gradient colors and opacity
    private func startVaporizingEffect() {
        
        if gradientLayer.animation(forKey: "colorChange") == nil{
            let colorAnimation = CABasicAnimation(keyPath: "colors")
            colorAnimation.fromValue = [UIColor.systemBlue.cgColor, UIColor.systemTeal.cgColor, UIColor.cyan.cgColor]
            colorAnimation.toValue = [UIColor.blue.cgColor, UIColor.systemPurple.cgColor, UIColor.systemIndigo.cgColor]
            colorAnimation.duration = 1.5
            colorAnimation.autoreverses = true
            colorAnimation.repeatCount = .infinity
            gradientLayer.add(colorAnimation, forKey: "colorChange")
        }
        
        if layer.animation(forKey: "opacityPulse") == nil {
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 1.0
            opacityAnimation.toValue = 0.9
            opacityAnimation.duration = 1.5
            opacityAnimation.autoreverses = true
            opacityAnimation.repeatCount = .infinity
            layer.add(opacityAnimation, forKey: "opacityPulse")
        }
        
    }
    
    func stopVaporizingEffect() {
        gradientLayer.removeAnimation(forKey: "colorChange")
        layer.removeAnimation(forKey: "opacityPulse")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            startVaporizingEffect()
        }else{
            stopVaporizingEffect()
        }
    }
}

