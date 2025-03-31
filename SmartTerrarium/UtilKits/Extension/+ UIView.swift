//
//  + UIView.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 03/11/2024.
//

import Foundation
import UIKit

enum LinePosition {
    case top
    case bottom
}

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views { addSubview(view)}
    }
    
    func pinToEdges(to superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    func addLine(position: LinePosition, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .bottom:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
    
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
    
    func dribble(scale: CGFloat? = nil, duration: CGFloat? = nil) {
        let scale = scale ?? 1.2
        let duration = duration ?? Constants.animationDuration
        UIView.animate(withDuration: duration,
                       delay: .zero,
                       options: .curveEaseInOut,
                       animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: duration,
                           delay: .zero,
                           animations: {
                self?.transform = .identity
            })
        })
    }
    
    func hideWithAnimation(duration: CGFloat? = .zero, removeFromSuperview: Bool? = false) {
        UIView.animate(withDuration: duration ?? Constants.alphaChangeDuration,
                       delay: .zero,
                       options: .curveEaseInOut,
                       animations: {
            self.alpha = .zero
        }, completion: { [weak self] _ in
            self?.isHidden = true
            if removeFromSuperview ?? false {
                self?.removeFromSuperview()
            }
        })
    }
    
    func showWithAnimation(duration: CGFloat? = .zero, removeFromSuperview: Bool? = false) {
        self.isHidden = false
        UIView.animate(withDuration: duration ?? Constants.alphaChangeDuration,
                       delay: .zero,
                       options: .curveEaseInOut,
                       animations: {
            self.alpha = 1.0
        }, completion: { [weak self] _ in
            if removeFromSuperview ?? false {
                self?.removeFromSuperview()
            }
        })
    }
}
