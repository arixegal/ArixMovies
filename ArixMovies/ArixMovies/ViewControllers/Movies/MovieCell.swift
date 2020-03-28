//
//  MovieCell.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    var movie : Movie?{
        didSet{
            guard let movieEntity = movie else {return}
            
            if let posterFullURL = movieEntity.posterFullURL{
                ivPoster.alpha = 1
                ivPoster.downloaded(from: posterFullURL)
            }
            else{
                ivPoster.alpha = 0
            }
            
            lblTitle.text = movieEntity.title ?? ""
            lblOverview.text = movieEntity.overview ?? ""
            lblDate.text = movieEntity.releaseDateForDisplay
        }
    }
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMain.layer.borderColor = UIColor.gray.cgColor
        viewMain.layer.borderWidth = 0.5
        viewMain.layer.shadowColor = UIColor.gray.cgColor
        viewMain.layer.shadowOpacity = 0.5
        viewMain.layer.shadowOffset = .zero
        viewMain.layer.shadowRadius = 4
        
    }


}
