//
//  WaterCard.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 13/11/2024.
//


import UIKit

class WaterCard: UIView {

    let waterLbl     = CustomLabel1(textAlignment: .center, fontSize: 24, textWeight: .semibold, text: "Moisture")
    let valueLbl     = CustomLabel1(textAlignment: .center, fontSize: 24, textWeight: .regular, text: "")
    let gradientLayer = CAGradientLayer()
    var dropLayers: [CALayer] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        configCard()
        setupGradientLayer()
        configLabels()
        startWaterAnimation()  // Start the animation when the card is initialized
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        waterLbl.textColor   = .white
        valueLbl.textColor   = .white
        valueLbl.text        = "0"

        addSubViews(waterLbl, valueLbl)

        NSLayoutConstraint.activate([
            waterLbl.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            waterLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLbl.topAnchor.constraint(equalTo: waterLbl.bottomAnchor, constant: 16),
            valueLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    func setMoisture(_ moisture: String) {
        valueLbl.text = "\(moisture)"
        startWaterAnimation()
    }

    private func startWaterAnimation() {
        dropLayers.forEach { $0.removeFromSuperlayer() }
        dropLayers.removeAll()
        

        for _ in 0..<8 {
            let dropLayer = CALayer()
            dropLayer.frame = CGRect(x: bounds.midX - 20 + CGFloat.random(in: -50...50), y: -20, width: 20, height: 20)
            dropLayer.backgroundColor = UIColor.blue.withAlphaComponent(0.1).cgColor
            dropLayer.cornerRadius = 10
            layer.addSublayer(dropLayer)
            dropLayers.append(dropLayer)

            let fallAnimation = CABasicAnimation(keyPath: "position.y")
            fallAnimation.fromValue = -20
            fallAnimation.toValue = bounds.height
            fallAnimation.duration = 2.0
            fallAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
            fallAnimation.fillMode = .forwards
            fallAnimation.isRemovedOnCompletion = false

            let breakApartAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            breakApartAnimation.values = [1.0, 1.5, 0.0]
            breakApartAnimation.keyTimes = [0, 0.6, 1]
            breakApartAnimation.duration = 2.0
            breakApartAnimation.fillMode = .forwards
            breakApartAnimation.isRemovedOnCompletion = false

            dropLayer.add(fallAnimation, forKey: "falling")
            dropLayer.add(breakApartAnimation, forKey: "breaking")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.startWaterAnimation()
        }
    }

    func stopWaterAnimation() {
        dropLayers.forEach { $0.removeAllAnimations() }
    }
}
