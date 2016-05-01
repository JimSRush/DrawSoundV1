//
//  ViewController.swift
//  DrawSoundV1
//
//  Created by Jim Rush on 1/05/16.
//  Copyright © 2016 Jim Rush. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tempDrawImage: UIImageView!
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var brushWidth: CGFloat = 10.0
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 1.0, 1.0),
        (1.0,1.0,0),
        (1.0,0,1.0),
        (0,0,0)
        ]
    
    @IBAction func colourPressed(sender: AnyObject) {
        
        var index = sender.tag ?? 0
        
        if index < 0 || index >= colors.count {
            index = 0
        }
        
        print("pressed \(index)")
        
        (red, green, blue) = colors[index]
        print(colors[index])
        if index == colors.count - 1 {
            opacity = 1.0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.locationInView(self.view)
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempDrawImage.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
    
        CGContextMoveToPoint(context, fromPoint.x, toPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, brushWidth)
        
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        print(red, green, blue)
        CGContextSetBlendMode(context, .Normal)
        
        CGContextStrokePath(context)
        
        tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        tempDrawImage.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.locationInView(view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
     }
    
     override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !swiped {
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        UIGraphicsBeginImageContext(mainImage.frame.size)
        mainImage.image?.drawInRect(CGRect(x:0,
                                           y:0,
                                           width: view.frame.size.width,
                                           height: view.frame.size.height),
                                        blendMode: .Normal, alpha: 1.0)
        
        tempDrawImage.image?.drawInRect(CGRect(x:0,
                                               y:0,
                                               width: view.frame.size.width,
                                               height: view.frame.size.height),
                                        blendMode: .Normal, alpha: opacity)
        mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempDrawImage.image = nil
        
    }
    

}

