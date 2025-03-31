//
//  WaterCell.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 27/12/2024.
//

import Foundation
import UIKit

class WaterCell: UITableViewCell {
    static var tvcell: String = "WaterCell"
    
    private var date: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
         
        return title
    }()
    
    private var startTime: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    private var stopTime: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init: has not been implemented")
    }
    
    func setupConstraints() {
        self.contentView.addSubViews(date,startTime,stopTime)
        
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            date.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            startTime.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 20),
            startTime.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            stopTime.bottomAnchor.constraint(equalTo: startTime.bottomAnchor),
            stopTime.leftAnchor.constraint(equalTo: startTime.rightAnchor, constant: 20)
        ])
    }
    
    func config(with cellItem: WaterSchedule){
        date.text = cellItem.date
        startTime.text = cellItem.startTime
        stopTime.text = cellItem.endTime
    }
}
