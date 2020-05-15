//
//  HomeConfigure.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 15/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Foundation
import UIKit

class HomeConfigurator {
    static let share = HomeConfigurator()
    
    var viewController: HomeViewController?
    
    func setup(view: HomeViewController) {
        self.viewController = view
        let wareFrame = HomeWireframe(view: view)
        let homeManager = HomeManager()
        let interactor = HomeInteractor(homeManager: homeManager)
        let presenter = HomePresenter(view: view, wireframe: wareFrame, interactor: interactor)
        presenter.interactor = interactor
        presenter.wireframe = wareFrame
        presenter.view = view
        interactor.delegate = presenter
        wareFrame.view = view
        viewController?.presenter = presenter
    }
}

