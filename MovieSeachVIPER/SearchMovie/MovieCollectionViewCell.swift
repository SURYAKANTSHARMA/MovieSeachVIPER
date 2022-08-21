//
//  MovieCollectionViewCell.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//
import UIKit

// MARK: - Movie Collection View Cell

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet var posterImageView: CacheImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var favouriteButton: UIButton!
    var movie: Movie?

    @IBAction func favouriteButtonTapped() {
        guard let movie = movie else { return }
        movie.isFavourite = !movie.isFavourite
    }

}

// MARK: - Cell Configuration

extension MovieCollectionViewCell {

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

        self.updateFavourite()
        self.movie?.onChangeFavourite = { [weak self] _ in
            self?.updateFavourite()
        }
        
    }
    
    func updateFavourite() {
        guard let movie = movie else { return }
        favouriteButton.setImage(
            movie.isFavourite ?
            UIImage.filledHeart :
                UIImage.emptyHeart,
                for: .normal)

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
