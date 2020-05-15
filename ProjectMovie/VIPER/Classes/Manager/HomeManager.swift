//
//  HomeManager.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 15/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift
import UIKit

public protocol IHomeManager: class {
    func processLoadDiscover(id: String, page: Int, completion: @escaping (_ success: Bool?, _ response: [DiscoverResults]?) -> Void)
}

public class HomeManager: IHomeManager {
    var DiscoverArray: [DiscoverResults] = []
    var disposeBag: DisposeBag! = DisposeBag()
    var provider: MoyaProvider<MovieAPI>! = MoyaProvider<MovieAPI>(plugins: [CompleteUrlLoggerPlugin()])
    
    
    public func processLoadDiscover(id: String, page: Int, completion: @escaping (Bool?, [DiscoverResults]?) -> Void) {
        provider.rx.request(.getDiscover(id, "\(page)"))
            .filterSuccessfulStatusCodes()
            .mapJSON().subscribe(onSuccess: { response in
                guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else { return }
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(DiscoverModel.self, from: jsonData)
                    if page == 1 {
                        self.DiscoverArray.removeAll()
                    }
                    res.results?.forEach({ value in
                        self.DiscoverArray.append(value)
                        
                    })
                    completion(true, self.DiscoverArray)
                    
                } catch {
                    completion(false, nil)
                    print(error.localizedDescription)
                }
            }, onError: { error in
                completion(false, nil)
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}

