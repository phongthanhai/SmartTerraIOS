//
//  HealthCard.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 11/11/2024.
//

import Foundation
import UIKit

class HealthCard: UIView{
    
    let imageView = UIImageView()
    let text      = CustomLabel1(textAlignment: .left, fontSize: 32, textWeight: .semibold, text: "")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCard()
        addGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCard(){
        translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.numberOfLines = 0
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        
        //Config Card
        layer.cornerRadius  = 12
        layer.masksToBounds = true
        
        let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [UIColor.systemGreen.cgColor, UIColor.systemGreen.withAlphaComponent(0.7).cgColor]
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 1, y: 1)
                gradientLayer.frame = bounds
                gradientLayer.cornerRadius = 12
                layer.insertSublayer(gradientLayer, at: 0)
        
        self.addSubViews(imageView,text)
        NSLayoutConstraint.activate([
                
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                imageView.widthAnchor.constraint(equalToConstant: 100),
                imageView.heightAnchor.constraint(equalToConstant: 100),
                
                text.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
                text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                text.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10)
        ])
        
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    func setLbl(label: String){
        text.text = label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update gradient layer frame when the view’s bounds change
        if let gradientLayer = layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }
    
    private func addGestures(){
            // Use only a long press gesture to handle both touch down and touch up
            let touchDown = UILongPressGestureRecognizer(target: self, action: #selector(handleTouch(_:)))
            touchDown.minimumPressDuration = 0  // Immediate trigger on touch
            addGestureRecognizer(touchDown)
        }
        
        @objc private func handleTouch(_ gesture: UILongPressGestureRecognizer){
            if gesture.state == .began {
                // Scale up and add shadow when touch begins
                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                    self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)  // Slight expansion
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowOffset = CGSize(width: 0, height: 10)
                    self.layer.shadowRadius = 10
                    self.layer.shadowOpacity = 0.3
                })
            } else if gesture.state == .ended || gesture.state == .cancelled {
                // Reset to original size and remove shadow when touch ends
                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                    self.transform = CGAffineTransform.identity  // Reset to original size
                    self.layer.shadowOpacity = 0  // Remove shadow after touch
                })
            }
        }
    
    
    
}
