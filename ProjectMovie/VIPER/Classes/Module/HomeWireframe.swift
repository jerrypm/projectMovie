//
//  HomeWireframe.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 15/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Foundation

public protocol IHomeWireframe: class {
    func navigateToGenres()
    func navigeteToDetail(_ id: String)
}

public class HomeWireframe: IHomeWireframe {
    weak var view: HomeViewController?
    
    init(view: HomeViewController) {
        self.view = view
    }
    
    public func navigateToGenres() {
        let vc = MainViewController()
        vc.state = .genre
        vc.delegate = view
        view?.present(vc, animated: true, completion: nil)
    }
    
    public func navigeteToDetail(_ id: String) {
        let vc = DetailViewController()
        vc.idMovie = id
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
