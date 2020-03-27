//
//  MoviesViewController.swift
//  ArixMovies
//
//  Created by Admin on 27/03/2020.
//  Copyright © 2020 ArixHome. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    var allPagesAlreadyFetched = false
    var movieClient : MovieClient?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if allPagesAlreadyFetched{
            showMovies()
        }
    }
}

private typealias tableView = MoviesViewController
extension tableView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieClient?.combinedResults.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        return cell
    }
}

private typealias movieClient = MoviesViewController
extension movieClient : MoviesClientDelegate
{
    func allPagesFetched() {
        allPagesAlreadyFetched = true
        showMovies()
    }
    
    func showMovies(){
        if self.isViewLoaded{
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}

