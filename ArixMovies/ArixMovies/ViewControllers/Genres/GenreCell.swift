//
//  GenreCell.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import UIKit

private typealias colorsRange = (fromColor: UIColor, toColor: UIColor)

class GenreCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl: UILabel!
    
    var genreTitle : String?{
        didSet{
            lbl.text = genreTitle ?? ""
        }
    }
    
    override func awakeFromNib() {
        
        //self.contentView.backgroundColor = getRandomColor()
        
        let fromToColors = getRandomColor()
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [fromToColors.fromColor.cgColor, fromToColors.toColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)

        self.contentView.layer.insertSublayer(gradient, at: 0)
    }
    
    fileprivate func getRandomColor() -> colorsRange
    {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        let fromColor = UIColor(red:red, green: green, blue: blue, alpha: 1.0)
        let toColor = UIColor(red:red, green: green, blue: blue, alpha: 0.5)
        
        return (fromColor: fromColor, toColor:toColor)
    }
}
