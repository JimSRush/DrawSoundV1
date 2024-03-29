//
//  ViewController.swift
//  DrawSoundV1
//
//  Created by Jim Rush on 1/05/16.
//  Copyright © 2016 Jim Rush. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var tempDrawImage: UIImageView!
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var brushWidth: CGFloat = 5.0
    let audioController = AudioController()
    
   
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 1.0, 1.0),
        (1.0,1.0,0),
        (1.0,0,1.0),
        (0,0,0)
        ]
    
    @IBAction func colourPressed(sender: AnyObject) {
        
        var index = sender.tag ?? 0
        audioController.playSound()
        if index < 0 || index >= colors.count {
            index = 0
        }
        
        (red, green, blue) = colors[index]
       
        if index == colors.count - 1 {
            opacity = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, .Normal)
   
        CGContextStrokePath(context)
        
        tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        tempDrawImage.alpha = opacity
        UIGraphicsEndImageContext()
        
        audioController.alterSound(Double(fromPoint.y * 27.5))
        

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
        printSomeRGBValues()
        
    }
    
    func printSomeRGBValues(){
        //we have a UIImage
        //we need to parse it into an array of either color values
        //or pure int values
        //we can then perform some mathsy maths and work out what the colour composition is
        //and apply this to the audiosource(s) in some way
        
    }
}

