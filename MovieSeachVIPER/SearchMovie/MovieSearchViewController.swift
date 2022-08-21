//
//  MovieSearchViewController.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//
import UIKit

class MovieSearchViewController: UIViewController, MovieSearchView {
    
   var presenter: MovieSearchPresenterInterface?
   var movies = [Movie]()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var findItButton: UIButton!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var bannerLabel: UILabel!
    @IBOutlet weak var bannerBackground: UIView!
    @IBOutlet weak var bannerSquashConstraint: NSLayoutConstraint!
    @IBOutlet weak var noResultsView: UIView!

    @IBAction func onTitleEditingDidEnd(_ sender: Any) {
        startSearch()
    }

    @IBAction func onTappedFindIt(_ sender: Any) {
        titleTextField.resignFirstResponder()
        startSearch()
    }

    func startSearch() {
        guard let title = titleTextField.text else {
            return
            
        }
        
        presenter?.fetchItems(searchText: title)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bannerSquashConstraint.priority = .defaultHigh
        bannerLabel.alpha = 0.0
        bannerBackground.alpha = 0.0
    }



   func updateUI(_ Movies: [Movie]) {
       self.movies = Movies
       updateSearchResults()
   }
   
   func showError(message: String) {
       showErrorMessage(message)
   }

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        presenter?.favouriteButtonTapped()
    }
    
}

extension MovieSearchViewController {

    func updateSearchResults() {
        resultsCollectionView.reloadData()
        noResultsView.alpha = 0.0
        resultsCollectionView.alpha = 1.0
    }

    func updateNoMoviesFound() {
        resultsCollectionView.reloadData()
        noResultsView.alpha = 1.0
        resultsCollectionView.alpha = 0.0
    }

    // Integrate poster images into the UI as they become available.
    func posterBecameAvailable(imdbId: String, posterImage: UIImage) {
        // Determine if any visible cells need the poster (if not the
        // poster will get picked up when any fresh cell is configured).
        resultsCollectionView.visibleCells.forEach { cell in
            guard
                let movieCell = cell as? MovieCollectionViewCell,
                movieCell.movie?.imdbId == imdbId
            else {
                return
            }

            movieCell.showPoster(image: posterImage)
        }
    }

}

// MARK: - Error Message Display

extension MovieSearchViewController {
    private static let animationDuration = 0.4

    func showErrorMessage(_ message: String) {
        bannerLabel.text = message
        self.bannerSquashConstraint.priority = .defaultLow
        self.bannerBackground.alpha = 1.0

        UIView.animateKeyframes(
            withDuration: MovieSearchViewController.animationDuration,
            delay: 0.0,
            options: .layoutSubviews
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: 0.0,
                relativeDuration: 0.5
            ) {
                self.bannerSquashConstraint.priority = .defaultLow
                self.view.layoutIfNeeded()
            }

            UIView.addKeyframe(
                withRelativeStartTime: 0.5,
                relativeDuration: 0.5
            ) {
                self.bannerLabel.alpha = 1.0
            }
        }
    }

    func hideErrorMessage() {
        UIView.animateKeyframes(
            withDuration: MovieSearchViewController.animationDuration,
            delay: 0.0,
            options: .layoutSubviews
        ) {
            UIView.addKeyframe(
                withRelativeStartTime: 0.0,
                relativeDuration: 0.5
            ) {
                self.bannerLabel.alpha = 0.0
            }

            UIView.addKeyframe(
                withRelativeStartTime: 0.5,
                relativeDuration: 0.5
            ) {
                self.bannerSquashConstraint.priority = .defaultHigh
                self.view.layoutIfNeeded()
                self.bannerBackground.alpha = 0.0
            }
        }
    }

}

// MARK: - Collection View Delegate

extension MovieSearchViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        guard
            let movieCell = collectionView.cellForItem(
                at: indexPath
            ) as? MovieCollectionViewCell,
            let movie = movieCell.movie
        else {
            return false
        }

        presenter?.cellTapped(at: movie)
        return false
    }

}

// MARK: - Collection View Data Source

extension MovieSearchViewController: UICollectionViewDataSource {

    private static let movieCellIdentifier = "MovieCollectionViewCell"

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
         movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let movieCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieSearchViewController.movieCellIdentifier,
                for: indexPath
            ) as? MovieCollectionViewCell
        else {
            fatalError()
        }
        let movie = movies[indexPath.row]
        movieCell.configure(movie: movie)

        return movieCell
    }
    
    

}

// MARK: - Flow Layout Delegate

extension MovieSearchViewController: UICollectionViewDelegateFlowLayout {

    private static let screenWidth: CGFloat = {
        UIScreen.main.bounds.width
    }()
    
    private static let minWidth: CGFloat = 324
    private static let cellHeight: CGFloat = 250

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let twoPer = (0.9 * MovieSearchViewController.screenWidth) / 2
        if twoPer > Self.minWidth {
            return CGSize(width: twoPer, height: Self.cellHeight)
        }

        return CGSize(width: Self.minWidth, height: Self.cellHeight)
    }

}

// MARK: - Text Field Delegate

extension MovieSearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
