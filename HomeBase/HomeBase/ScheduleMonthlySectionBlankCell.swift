//
//  ScheduleMonthlySectionBlankCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleMonthlySectionBlankCell: UITableViewCell {

    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 192, green: 222, blue: 229, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}
