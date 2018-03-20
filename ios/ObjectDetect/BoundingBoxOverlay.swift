//
//  BoundingBoxOverlay.swift
//  ObjectDetectAI
//
//  Created by Jack Serrino on 3/21/18.
//

import UIKit

class BoundingBoxOverlay: UIView {
    var boxes:[Any] = [];
    
    override var clearsContextBeforeDrawing: Bool {
        get {
            return true
        }
        set {
            
        }
    };
    override var isOpaque: Bool {
        get {
            return false
        }
        set {
            // you can leave this empty...
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        for box in (self.boxes as! [NSDictionary]) {
            let top: Int = box.object(forKey: "top") as! Int
            let left: Int = box.object(forKey: "left") as! Int
            let bottom: Int = box.object(forKey: "bottom") as! Int
            let right: Int = box.object(forKey: "right") as! Int
            let class_name: String = box.object(forKey: "class_name") as! String
            
            
            let textFont = UIFont(name: "Helvetica", size: 48)!
            let textFontAttributes = [
                NSFontAttributeName: textFont,
                NSForegroundColorAttributeName: UIColor.blue,
            ] as [String : Any]
            
            context?.setLineWidth(4.0)
            context?.setStrokeColor(UIColor.blue.cgColor)
            let rectangle = CGRect(x: left, y: top, width: (right-left), height: (bottom-top))
            context?.addRect(rectangle)
            context?.strokePath()
            
            class_name.draw(in: rectangle, withAttributes: textFontAttributes)
        }
    }
    
    func assignBoxes(_ newBoxes:[Any]) {
        self.boxes = newBoxes;
        self.setNeedsDisplay();
    }

}