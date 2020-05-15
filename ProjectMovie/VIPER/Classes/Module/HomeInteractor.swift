//
//  HomeInteractor.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 15/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Foundation

public protocol HomeInteractorDelegate: class {
    func presentSuccess(_ result: [DiscoverResults]?)
    func presentFailure(_ message: String)
}

public protocol IHomeInteractor: class {
    var delegate: HomeInteractorDelegate? { get set }
    func handleLoadDiscover(_ id: String, _ page: Int)
}

public class HomeInteractor: IHomeInteractor {
    
    var homeManager: IHomeManager?
    public var delegate: HomeInteractorDelegate?
    
    init(homeManager: IHomeManager) {
        self.homeManager = homeManager
    }
    
    public func handleLoadDiscover(_ id: String, _ page: Int) {
        self.homeManager?.processLoadDiscover(id: id, page: page) { (status, result) in
            if status == true {
                self.delegate?.presentSuccess(result)
            } else {
                self.delegate?.presentFailure("Error Request")
            }
        }
    }
    
}
