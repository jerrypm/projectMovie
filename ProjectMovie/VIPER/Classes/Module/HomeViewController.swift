//
//  HomeViewController.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 15/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

// Example use VIPER

import UIKit

public protocol IHomeView: class {
    func displaySucces(_ result: [DiscoverResults]?)
    func displayFailure(_ message: String)
}

public class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: IHomePresenter?
    var discoverArray: [DiscoverResults] = []
    var pages: Int = 1
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discover Movies"
        HomeConfigurator.share.setup(view: self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleFilter))
        setComponent()
        bindData("", 1)
        
    }
    
    func setComponent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: GenreTableViewCell.self)
        tableView.register(cellType: DiscoverTableViewCell.self)
        tableView.separatorColor = UIColor.clear
        tableView.rowHeight = 150
    }
    
    func bindData(_ id: String, _ page: Int) {
        self.presenter?.getDiscover(id, page)
    }
    
    @objc func handleFilter() {
        self.presenter?.navigateToGenres()
    }
    
}

extension HomeViewController: IHomeView, IHomeGenre {
    public func displaySucces(_ result: [DiscoverResults]?) {
        result?.forEach({ data in
            self.discoverArray.append(data)
        })
        self.tableView.reloadData()
    }
    
    public func displayFailure(_ message: String) {
        AlertHelper.share.show(in: self, title: "", message: message, completion: nil)
    }
    
    public func getIdGenre(_ id: String, _ page: Int) {
        self.discoverArray.removeAll()
        self.bindData(id, page)
    }
}

extension HomeViewController:  UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoverArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DiscoverTableViewCell.self, for: indexPath)
        cell.data = discoverArray[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let idMovie = self.discoverArray[indexPath.row].id {
            self.presenter?.navigateToDetail("\(idMovie)")
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == discoverArray.count - 2 {
            pages = pages + 1
            bindData("", pages)
        }
    }
}
