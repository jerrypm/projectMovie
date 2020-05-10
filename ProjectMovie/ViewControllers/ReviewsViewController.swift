//
//  ReviesViewController.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 11/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var idMovie: String?
    let  viewModel = ReviewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setComponent()
        bindData()
    }

    private func setComponent() {
        tableView.register(cellType: ReviewsTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.clear
        tableView.dataSource = viewModel
    }
    
    private func bindData() {
        if let idMovie = self.idMovie {
            viewModel.getListComment(id: idMovie) { (status) in
                if status == true {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
