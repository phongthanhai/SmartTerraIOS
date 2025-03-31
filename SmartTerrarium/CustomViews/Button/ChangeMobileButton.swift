//
//  ChangeMobileButton.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 03/11/2024.
//

import Foundation
import UIKit

typealias MobileAction = () -> Void

final class ChangeMobileButton: UIButton {
    private let title: String
    private let action: MobileAction

    required init(title: String, action: @escaping MobileAction ) {
        self.title = title
        self.action = action
        super.init(frame: .zero)
        applySettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applySettings() {
        
        let isAdd = title == Strings.changemobile.rawValue
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: isAdd ? 15 : 15,
                                             weight: isAdd ? .semibold : .bold)
        backgroundColor = isAdd ? UIColor {
            traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return .systemGray4
            default:
                return .systemCyan
            }
        } : .systemRed
        
        
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        titleEdgeInsets = isAdd ? UIEdgeInsets(top: .zero,
                                               left: 1,
                                               bottom: 5,
                                               right: .zero) : .zero
        setGesture()
    }

    private func setGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(buttonTapped))
        gesture.minimumPressDuration = .zero
        gesture.numberOfTouchesRequired = 1
        addGestureRecognizer(gesture)
    }

    @objc private func buttonTapped(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: Constants.animationDuration,
                           delay: .zero,
                           animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                //VibrateManager.shared.vibrateFeedback(style: .rigid)
            })
        } else {
            UIView.animate(withDuration: Constants.animationDuration,
                           delay: .zero,
                           animations: {
                self.transform = .identity
            }, completion: { [weak self] finished in
                guard let self else { return }
                self.action()
            })
        }
    }

}
