//
//  HomePresenter.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 15/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Foundation

public protocol IHomePresenter: class {
    func getDiscover(_ id: String, _ page: Int)
    func navigateToGenres()
    func navigateToDetail(_ id: String)
}

public  class HomePresenter: IHomePresenter {
    var wireframe: IHomeWireframe?
    var interactor: IHomeInteractor?
    weak var view: IHomeView?
    
    public init(view: IHomeView, wireframe: IHomeWireframe, interactor: IHomeInteractor) {
        self.view = view
        self.wireframe = wireframe
        self.interactor = interactor
    }
    
    public func getDiscover(_ id: String, _ page: Int) {
        interactor?.handleLoadDiscover(id, page)
    }
    
    public func navigateToGenres() {
        wireframe?.navigateToGenres()
    }
    
    public func navigateToDetail(_ id: String) {
        wireframe?.navigeteToDetail(id)
    }
    
}

extension HomePresenter: HomeInteractorDelegate {
    public func presentSuccess(_ result: [DiscoverResults]?) {
        view?.displaySucces(result)
    }
    
    public func presentFailure(_ message: String) {
        view?.displayFailure(message)
    }
    
}
