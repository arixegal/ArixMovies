//
//  GenresViewController.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import UIKit

class GenresViewController: UIViewController {
    
    let genreClient = GenreClient()

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var constCollectionViewTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGenres()
    }
}

private typealias collectionView = GenresViewController
extension collectionView : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genreClient.fetchedResult?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
        if let genres = genreClient.fetchedResult?.genres
        {
            if indexPath.item < genres.count
            {
                cell.genreTitle = genres[indexPath.item].name
            }
        }
        return cell
    }
}

private typealias networking = GenresViewController
extension networking{
    func fetchGenres()
    {
        genreClient.fetchAllGenres(){[weak self] in
            if let _ = self?.genreClient.fetchedResult?.genres{
                self?.collectionView.reloadData()
                UIView.animate(withDuration: 1) {
                    self?.constCollectionViewTop.constant = 8
                    self?.view.layoutIfNeeded()
                }
            }
            else
            {
                // show error
            }
        }
    }
}
