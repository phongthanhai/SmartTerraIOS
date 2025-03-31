//
//  KeepAliveStatusLabel.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 29/12/2024.
//

import Foundation
import UIKit

class KeepAliveStatusLabel: CustomLabel1 {
    enum Status{
        case online, offline
    }
    
    func updateStatus(to status: Status) {
        switch status{
            case .online:
                self.text = "Online"
                self.textColor = .green
            case .offline:
                self.text = "Offline"
                self.textColor = .red
        }
    }
}
