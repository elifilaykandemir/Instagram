//
//  Label.swift
//  Instagram
//
//  Created by Elif İlay Eser

import UIKit

class Label : UILabel {

    init(labelText : String? ,labelFontNamed:String="Times New Roman" ,labelFontSize:CGFloat=12,labelNumberOfLines:Int=1) {
        super.init(frame: CGRect.zero)
        text = labelText
        font = UIFont(name: labelFontNamed, size: labelFontSize)
        numberOfLines = labelNumberOfLines
        
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          
      }

}
