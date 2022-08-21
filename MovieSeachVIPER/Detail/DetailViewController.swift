//
//  DetailViewController.swift
//  MovieSeachVIPER
//
//  Created by Suryakant Sharma on 20/08/22.
//

import UIKit

// MARK: - Detail View Controller

class DetailViewController: UIViewController, MovieDetailView {
    
    @IBOutlet weak var posterImageView: CacheImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet var favouriteButton: UIButton!

    var movie: Movie?
    private var movieDetail: MovieDetail?
    var presenter: MovieDetailPresenterInterface?

    private struct DetailItem {
        var heading: String
        var text: String
    }

    private var details = [DetailItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = movie?.imdbId else {
            return
        }
        if let movie = movie {
            configure(movie: movie)
        }
        presenter?.fetchDetails(imbdId: id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        titleLabel.text = movie?.title

        if let year = movie?.year {
            yearLabel.text = "(\(year))"
        } else {
            yearLabel.text = nil
        }

        self.detailTableView.reloadData()

        if details.count == 0 {
            showStateImage(image: UIImage(systemName: "timer"))
        }
    }
    
    func updateUI(_ detail: MovieDetail) {
        self.setMovieDetail(detail)
    }
    
    func showError(message: String) {
        self.setMovieDetailUnavailable()
    }

    @IBAction func favouriteButtonTapped() {
        guard let movie = movie else { return }
        movie.isFavourite = !movie.isFavourite
        favouriteButton.setImage(movie.isFavourite ? UIImage.filledHeart : UIImage.emptyHeart,
                                  for: .normal)

    }

}

// MARK: - Configuration

extension DetailViewController {

    func configure(movie: Movie) {
        self.movie = movie
        self.posterImageView.loadImage(urlString: movie.poster ?? "")
        favouriteButton.setImage(movie.isFavourite ? UIImage.filledHeart : UIImage.emptyHeart,
                                  for: .normal)

    }

    var imdbIdDisplayed: String? {
        self.movie?.imdbId
    }

    func setMovieDetail(_ movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        details = []

        func add(_ string: String?, heading: String) {
            guard let string = string, !string.isEmpty, string != "N/A" else {
                return
            }
            details.append(DetailItem(heading: heading, text: string))
        }

        add(movieDetail.director, heading: "Director")
        add(movieDetail.genre, heading: "Genre")
        add(movieDetail.plot, heading: "Plot")
        add(movieDetail.released, heading: "Release Date")
        add(self.movie?.type?.capitalized, heading: "Release Type")
        add(movieDetail.rated, heading: "Rated")
        add(movieDetail.actors, heading: "Actors")

        if let tableView = self.detailTableView {
            hideStateImage(animated: true)
            tableView.reloadData()
        }
    }

    func setMovieDetailUnavailable() {
        showStateImage(image: UIImage(systemName: "heart.slash"))
    }

}

// MARK: - State Image

private extension DetailViewController {
    static let animationDuration = 0.4

    func showStateImage(image: UIImage?) {
        guard let image = image else { return }

        if stateView.alpha > 0.0 {
            hideStateImage(animated: false)
        }

        self.stateImageView.image = image
        self.stateView.backgroundColor = UIColor(named: "Background")
        self.stateView.layer.borderWidth = 2.0
        self.stateView.layer.cornerRadius = 16.0
        self.stateView.layer.borderColor = UIColor(
            named: "MovieCellBackground"
        )?.cgColor

        UIView.animate(withDuration: DetailViewController.animationDuration) {
            self.detailTableView.alpha = 0.0
            self.stateView.alpha = 1.0
        }
    }

    func hideStateImage(animated: Bool) {
        UIView.animate(
            withDuration: animated
                ? DetailViewController.animationDuration
                : 0.0
        ) {
            self.detailTableView.alpha = 1.0
            self.stateView.alpha = 0.0
        }
    }

}

// MARK: - Table View Data Source

extension DetailViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        details.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "DetailTableViewCell"
            ) as? DetailTableViewCell
        else {
            fatalError()
        }

        let detail = details[indexPath.row]
        cell.headingLabel.text = detail.heading
        cell.detailLabel.text = detail.text

        return cell
    }

}
