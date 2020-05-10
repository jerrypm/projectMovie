//
//  MainViewModel.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 10/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift
import UIKit

class MainViewModel: NSObject {
    var genreArray: [Genres]?
    var DiscoverArray: [DiscoverResults] = []
    var disposeBag: DisposeBag! = DisposeBag()
    var provider: MoyaProvider<MovieAPI>! = MoyaProvider<MovieAPI>(plugins: [CompleteUrlLoggerPlugin()])
    var state: State?
    
    func loadListGenres(state: State, completion: @escaping (_ success: Bool?, _ error: String?) -> Void) {
        self.state = state
        provider.rx.request(.getGenres)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { response in
                guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else { return }
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(GenreModel.self, from: jsonData)
                    self.genreArray = res.genres
                    completion(true, "Success")
                    
                } catch {
                    completion(false, error.localizedDescription)
                    print(error.localizedDescription)
                }
            }, onError: { error in
                print(error.localizedDescription)
                completion(false, error.localizedDescription)
                
            }).disposed(by: disposeBag)
    }
    
    func loadDiscover(state: State, id: String, page: Int, completion: @escaping (_ success: Bool?, _ error: String?) -> Void) {
        self.state = state
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
                    completion(true, "Success")
                    
                } catch {
                    completion(false, error.localizedDescription)
                    print(error.localizedDescription)
                }
            }, onError: { error in
                completion(false, error.localizedDescription)
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}

extension MainViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if state == State.genre {
            return genreArray?.count ?? 0
        } else {
            return DiscoverArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if state == State.genre {
            let cell = tableView.dequeueReusableCell(with: GenreTableViewCell.self, for: indexPath)
            cell.genreLabel.text = genreArray?[indexPath.row].name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: DiscoverTableViewCell.self, for: indexPath)
            cell.data = DiscoverArray[indexPath.row]
            return cell
        }
    }
}
