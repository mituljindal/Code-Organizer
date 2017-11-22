//
//  CustomUITextView.swift
//  CodeOrganizer
//
//  Created by mitul jindal on 13/11/17.
//  Copyright © 2017 mitul jindal. All rights reserved.
//

import UIKit

class CustomUITextView: UITextView {
    
//    override init(frame: CGRect, textContainer: NSTextContainer?) {
//        super.init(frame: frame, textContainer: textContainer)
//
//        self.layer.borderColor = UIColor.gray.cgColor
//        self.layer.borderWidth = 0.225
//        self.textAlignment = .center
//
//        centerTextVertically()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

//        Text view border set and aligning text to center
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.225
        self.textAlignment = .center

        centerTextVertically()
    }
    
//    Vertical Center Alignment
    func centerTextVertically() {
        
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
