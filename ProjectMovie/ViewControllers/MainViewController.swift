//
//  MainViewController.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 10/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import UIKit

enum State {
    case genre
    case discover
    
    var title: String {
        switch self {
        case .genre:
            return "Movie Genres"
        default:
            return "Discover Movies"
        }
    }
}

public protocol IHomeGenre {
    func getIdGenre(_ id: String, _ page: Int)
}

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonClose: UIButton!
    fileprivate let viewModel = MainViewModel()
    
    fileprivate let activityView = UIActivityIndicatorView(style: .large)
    let fadeView: UIView = UIView()
    
    var state: State = .discover
    var idGenre: String?
    var didSelect: ((_ id: String, _ state: State) -> Void)?
    var pages: Int = 1
    public var delegate: IHomeGenre?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleFilter))
        title = state.title
        setComponent()
        bindData(1)
    }
    
    private func setComponent() {
        tableView.dataSource = viewModel
        tableView.delegate = self
        tableView.register(cellType: GenreTableViewCell.self)
        tableView.register(cellType: DiscoverTableViewCell.self)
        tableView.separatorColor = UIColor.clear
        buttonClose.isHidden = state == .discover ? true : false
    }
    
    private func bindData(_ page: Int) {
        showIndicatorLoading()
        switch state {
        case .genre:
            viewModel.loadListGenres(state: .genre) { status, _ in
                if status == true {
                    self.tableView.reloadData()
                    self.fadeView.removeFromSuperview()
                    self.activityView.stopAnimating()
                }
            }
        default:
            viewModel.loadDiscover(state: .discover, id: idGenre ?? "", page: page) { status, _ in
                if status == true {
                    self.tableView.reloadData()
                    self.fadeView.removeFromSuperview()
                    self.activityView.stopAnimating()
                }
            }
        }
    }
    
    @objc func handleFilter() {
        let vc = MainViewController()
        vc.state = .genre
        vc.didSelect = { [weak self] id, state in
            self?.state = state
            self?.idGenre = id
            self?.bindData(1)
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func handleButtonClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if state == .genre {
            dismiss(animated: true) {
                self.state = .discover
                let id = "\(self.viewModel.genreArray?[indexPath.row].id ?? 0)"
                self.delegate?.getIdGenre(id, 1)
            }
        } else {
            print("Go to detail")
            let detailVc = DetailViewController()
            if let idMovie = self.viewModel.DiscoverArray[indexPath.row].id {
                detailVc.idMovie = "\(idMovie)"
                navigationController?.pushViewController(detailVc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if state == .discover {
            return 150
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.DiscoverArray.count - 2 {
            pages = pages + 1
            bindData(pages)
        }
    }
}
