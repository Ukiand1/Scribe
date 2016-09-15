//
//  CircleButton.swift
//  Scribe
//
//  Created by Uroš Đurđević on 15/09/16.
//  Copyright © 2016 Uroš Đurđević. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet{
           setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView(){
        layer.cornerRadius = cornerRadius
    }

}
