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
    let movieClient = MovieClient(delegate: nil)

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constCollectionViewTop: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGenres()
        movieClient.getAllMoviePages()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        guard let genres = genreClient.fetchedResult?.genres else {return}
        guard indexPath.item < genres.count else {return}
        guard let VC = self.storyboard?.instantiateViewController(identifier: "MoviesViewController") as? MoviesViewController else {return}
        MovieClient.userSelectedGenreId = genres[indexPath.item].id
        VC.movieClient = movieClient
        movieClient.delegate = VC
        navigationController?.pushViewController(VC, animated: true)
    }
}

private typealias networking = GenresViewController
extension networking{
    func fetchGenres()
    {
        genreClient.fetchAllGenres(){[weak self] in
            if let _ = self?.genreClient.fetchedResult?.genres{
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
                UIView.animate(withDuration: 1) {
                    self?.constCollectionViewTop.constant = 18
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
