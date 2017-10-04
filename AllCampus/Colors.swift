//
//  Colors.swift
//  AllCampus
//
//  Created by Local Admin on 10/4/17.
//  Copyright © 2017 nikostudios. All rights reserved.
//
//Borrows from Dave Green "How to add gradient layer tutorial"
//www.youtube.com/watch?v=pabNgxzEaRk

import Foundation
import UIKit


//From arshad github
//gist.github.com/arshad/de147c42d7b3063ef7bc
// Creates a UIColor from a Hex string.
extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


class ColorsHandler{
    
    
    func getLoveGradient() -> CAGradientLayer {
        let topColor = UIColor(red: 0.6902, green: 0.4157, blue: 0.702, alpha: 1.0)
        let bottomColor = UIColor(hue: 0.6278, saturation: 0.68, brightness: 0.86, alpha: 1.0)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocation: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.locations = gradientLocation as [NSNumber]
        gradientLayer.colors = gradientColors
        return gradientLayer
    }
    
    func getRoseGradient() -> CAGradientLayer {
        let topColor = "#FFAFBD".hexColor
        let bottomColor = "#ffc3a0".hexColor
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocation: [Float] = [0.0, 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.locations = gradientLocation as [NSNumber]
        gradientLayer.colors = gradientColors
        return gradientLayer
    }
    
    /*EXAMPLE IMPLEMENTATION
     var gradient = ColorsHandler()
     var gradientLayer: CAGradientLayer
     gradientLayer = gradient.getLoveGradient()
     gradientLayer.frame = scroller.frame
     scroller.backgroundColor = .clear
     self.view.layer.insertSublayer(gradientLayer, at: 0)
 */
  
    
    
    
}
