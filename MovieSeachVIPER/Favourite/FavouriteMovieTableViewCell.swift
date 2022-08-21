//
//  FavouriteMovieTableViewCell.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 21/08/22.
//

import UIKit

class FavouriteMovieTableViewCell: UITableViewCell {
    
    @IBOutlet var posterImageView: CacheImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    var movie: Movie?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(movie: Movie) {
        self.movie = movie
        
        titleLabel.text = movie.title

        if let year = movie.year {
            yearLabel.text = "(\(year))"
        } else {
            yearLabel.text = nil
        }

        if let posterImage = movie.poster {
            posterImageView.urlString = posterImage
            posterImageView.loadImage(urlString: posterImage)
        } else {
            showPoster(image: nil)
        }
    }
    
    func showPoster(image: UIImage?) {
        posterImageView.backgroundColor = UIColor(named: "MovieCellBackground")

        if image == nil {
            posterImageView.tintColor = UIColor(named: "Title")
            posterImageView.image = UIImage(systemName: "video")
            posterImageView.alpha = 0.05
        } else {
            posterImageView.image = image
            posterImageView.alpha = 1.0
        }
    }
}
