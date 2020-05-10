//
//  DetailViewController.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 10/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var titleMovie: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var statusMovie: UILabel!
    @IBOutlet var genreMovie: UILabel!
    @IBOutlet var overviewMovie: UILabel!
    
    fileprivate let activityView = UIActivityIndicatorView(style: .large)
    let fadeView: UIView = UIView()
    
    var idMovie: String?
    var movieDetail: MovieDetailModel?
    let viewModel = DetailViewModel()
    var urlVideo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail Movie"
        bindData()
    }
    
    private func bindData() {
        showIndicatorLoading()
        if let idMovie = self.idMovie {
            handleGetUrl(idMovie)
            viewModel.detailMovie(id: idMovie) { status, response in
                if status == true {
                    if let result = response {
                        let urlStringBack = Config.URL.basePoster + (result.backdropPath ?? "")
                        let urlStringPoster = Config.URL.basePoster + (result.posterPath ?? "")
                        Helper.loadImage(imageView: self.backgroundImage, url: urlStringBack)
                        Helper.loadImage(imageView: self.posterImage, url: urlStringPoster)
                        self.titleMovie.text = result.title
                        self.releaseDate.text = result.releaseDate
                        self.statusMovie.text = result.status
                        self.genreMovie.text = self.viewModel.joinGenre(result.genres)
                        self.overviewMovie.text = result.overview
                        self.fadeView.removeFromSuperview()
                        self.activityView.stopAnimating()
                    }
                } else {
                    self.navigationController?.popViewController(animated: true)
                    AlertHelper.share.show(in: self, title: "The data couldn’t be read", message: "", completion: nil)
                }
            }
        }
    }
    
    private func showIndicatorLoading() {
        fadeView.frame = view.frame
        fadeView.backgroundColor = UIColor.white
        fadeView.alpha = 0.4
        view.addSubview(fadeView)
        view.addSubview(activityView)
        activityView.hidesWhenStopped = true
        activityView.center = view.center
        activityView.startAnimating()
    }
    
    private func handleGetUrl(_ id: String) {
        viewModel.getVideoLink(id: id) { url in
            self.urlVideo = url
        }
    }
    
    @IBAction func handleOpenTrailer(_ sender: Any) {
        let vc = PlayerViewController()
        vc.urlString = self.urlVideo
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func handleOpenReviews(_ sender: Any) {
        let vc = ReviewsViewController()
        vc.idMovie = self.idMovie
        navigationController?.pushViewController(vc, animated: true)
    }
}
