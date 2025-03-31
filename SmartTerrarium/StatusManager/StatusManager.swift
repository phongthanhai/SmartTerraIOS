//
//  StatusManager.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 29/12/2024.
//

import Foundation
import UIKit


class StatusManager {
    static let shared = StatusManager()
    
    let statusLabel: KeepAliveStatusLabel = {
        let label = KeepAliveStatusLabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private init(){}
}
