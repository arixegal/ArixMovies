//
//  GenreCell.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl: UILabel!
    
    var genreTitle : String?{
        didSet{
            lbl.text = genreTitle ?? ""
        }
    }
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = getRandomColor()
    }
    
    func getRandomColor() -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}
