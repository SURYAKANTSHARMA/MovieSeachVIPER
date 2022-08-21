//
//  FavouriteTableViewController.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import UIKit

class FavouriteTableViewController: UITableViewController {
    
    var movies: [Movie] = []
    var respository: OfflineFavouriteRepositoryInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            self.movies = try respository?.fetchFavourite() ?? []
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
         1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavouriteMovieTableViewCell.self), for: indexPath) as? FavouriteMovieTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(movie: movies[indexPath.row])
        return cell
    }

}
