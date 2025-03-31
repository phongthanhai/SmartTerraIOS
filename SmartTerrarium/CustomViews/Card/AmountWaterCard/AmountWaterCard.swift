import UIKit

class AmountWaterCard: UIView {

    let waterAmountLbl = CustomLabel1(textAlignment: .center, fontSize: 24, textWeight: .semibold, text: "Watered")
    let valueLbl       = CustomLabel1(textAlignment: .center, fontSize: 24, textWeight: .regular, text: "")
    let gradientLayer  = CAGradientLayer()
    var waterLevelLayer: CALayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configCard()
        setupGradientLayer()
        configLabels()
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
        waterAmountLbl.textColor = .white
        valueLbl.textColor       = .white
        valueLbl.text            = "0 ml" // Starting value

        addSubViews(waterAmountLbl, valueLbl)

        NSLayoutConstraint.activate([
            waterAmountLbl.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            waterAmountLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLbl.topAnchor.constraint(equalTo: waterAmountLbl.bottomAnchor, constant: 16),
            valueLbl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    func setWaterAmount(_ amount: Int) {
        valueLbl.text = "\(amount) ml"
        startFillAnimation()
    }
    /*
    private func startFillAnimation() {
        if waterLevelLayer == nil {
            waterLevelLayer = CALayer()
            waterLevelLayer?.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
            waterLevelLayer?.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 0)
            layer.addSublayer(waterLevelLayer!)
        }

        let targetHeight: CGFloat = bounds.height * 0.4

        let fillAnimation = CAKeyframeAnimation(keyPath: "bounds.size.height")
        fillAnimation.values = (0...20).map { i -> CGFloat in
            let normalizedIndex = CGFloat(i) / 20.0
            return targetHeight * (0.5 + 0.5 * sin(3 * .pi * normalizedIndex))
        }
        fillAnimation.duration = 3.0
        fillAnimation.repeatCount = .infinity
        fillAnimation.timingFunctions = Array(repeating: CAMediaTimingFunction(name: .easeInEaseOut), count: 20)

        waterLevelLayer?.add(fillAnimation, forKey: "filling")
    }
     */
    
    func startFillAnimation() {
        if waterLevelLayer == nil {
            waterLevelLayer = CALayer()
            waterLevelLayer?.backgroundColor = UIColor.blue.withAlphaComponent(0.2).cgColor
            waterLevelLayer?.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 0)
            layer.addSublayer(waterLevelLayer!)
        }

        let targetHeight: CGFloat = bounds.height * 0.4

        // Keyframe animation to simulate the wave motion.
        let fillAnimation = CAKeyframeAnimation(keyPath: "bounds.size.height")
        fillAnimation.values = (0...20).map { i -> CGFloat in
            let normalizedIndex = CGFloat(i) / 20.0
            return targetHeight * (0.5 + 0.5 * sin(3 * .pi * normalizedIndex))
        }
        fillAnimation.duration = 3.0
        fillAnimation.repeatCount = .infinity
        fillAnimation.timingFunctions = Array(repeating: CAMediaTimingFunction(name: .easeInEaseOut), count: 20)
        fillAnimation.fillMode = .forwards
        fillAnimation.isRemovedOnCompletion = false  // Ensure animation continues even if view hierarchy changes

        // Add the animation to the layer.
        waterLevelLayer?.add(fillAnimation, forKey: "filling")
    }

    
    func stopFillAnimation(){
        waterLevelLayer?.removeAllAnimations()
    }
}
