//
//  DetailViewModel.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 11/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift
import SwiftyJSON
import UIKit

class DetailViewModel: NSObject {
    var disposeBag: DisposeBag! = DisposeBag()
    var provider: MoyaProvider<MovieAPI>! = MoyaProvider<MovieAPI>(plugins: [CompleteUrlLoggerPlugin()])
    
    func detailMovie(id: String, completion: @escaping (_ success: Bool?, _ response: MovieDetailModel?) -> Void) {
        provider.rx.request(.getMovieDetail(id))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { response in
                guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else { return }
                let json = JSON(jsonData)
                let resIn = MovieDetailModel(json: json)
                completion(true, resIn)
                
            }, onError: { error in
                print(error.localizedDescription)
                completion(false, nil)
                
            }).disposed(by: disposeBag)
    }
    
    func getVideoLink(id: String, completion: @escaping (_ urlLink: String?) -> Void) {
        provider.rx.request(.getVideo(id))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { response in
                guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else { return }
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(MovieVideoModel.self, from: jsonData)
                    
                    if let urlYoutube = res.results?.first?.key {
                        completion(Config.URL.baseYoutube + urlYoutube)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func joinGenre(_ arrayString: [MovieDetailGenres]?) -> String {
        var genres = [String]()
        guard let arr = arrayString else { return "" }
        arr.forEach { genres.append($0.name ?? "") }
        
        return genres.joined(separator: ", ")
    }
}
