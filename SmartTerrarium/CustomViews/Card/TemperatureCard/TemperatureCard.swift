//
//  TemperatureCard.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 14/11/2024.
//

import Foundation
import UIKit

class TemperatureCard: UIView{
    
    let tempLbl  = CustomLabel1(textAlignment: .center, fontSize: 24, textWeight: .semibold, text: "Temperature")
    var valueLbl = CustomLabel1(textAlignment: .center, fontSize: 24, textWeight: .regular, text: "")
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
    
    private func setupGradientLayer(colors: [UIColor] = [UIColor.systemPink, UIColor.systemOrange]) {
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configLabels() {
        tempLbl.textColor   = .white
        valueLbl.textColor  = .white
        valueLbl.text       = "29°C"
        
        addSubViews(tempLbl, valueLbl)
        
        NSLayoutConstraint.activate([
            tempLbl.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            tempLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLbl.topAnchor.constraint(equalTo: tempLbl.bottomAnchor, constant: 16),
            valueLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func setTemperature(_ temperature: String) {
        valueLbl.text = temperature
    }
    
    // Vaporizing effect: pulse between two gradient colors and opacity
    private func startVaporizingEffect() {
        if gradientLayer.animation(forKey: "colorChange") == nil{
            let colorAnimation = CABasicAnimation(keyPath: "colors")
            colorAnimation.fromValue = [UIColor.systemPink.cgColor, UIColor.systemOrange.cgColor]
            colorAnimation.toValue = [UIColor.systemRed.cgColor, UIColor.systemYellow.cgColor]
            colorAnimation.duration = 1.5
            colorAnimation.autoreverses = true
            colorAnimation.repeatCount = .infinity
            gradientLayer.add(colorAnimation, forKey: "colorChange")
        }
        
        if gradientLayer.animation(forKey: "opacityPulse") == nil{
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
        if window != nil{
            startVaporizingEffect()
        }else{
            stopVaporizingEffect()
        }
    }
}
