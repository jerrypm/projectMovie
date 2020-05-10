//
//  ReviewViewModel.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 11/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift
import UIKit

class ReviewViewModel: NSObject {
    var reviewArray: [MovieReviewsResults]?
    var disposeBag: DisposeBag! = DisposeBag()
    var provider: MoyaProvider<MovieAPI>! = MoyaProvider<MovieAPI>(plugins: [CompleteUrlLoggerPlugin()])

    func getListComment(id: String, completion: @escaping (_ success: Bool?) -> Void) {
        provider.rx.request(.getReviews(id))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .subscribe(onSuccess: { response in
                guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else { return }
                do {
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(MovieReviewsModel.self, from: jsonData)
                    self.reviewArray = res.results
                    completion(true)

                } catch {
                    print(error.localizedDescription)
                }

            }, onError: { error in
                print(error.localizedDescription)
                completion(false)

            }).disposed(by: disposeBag)
    }
}

extension ReviewViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ReviewsTableViewCell.self, for: indexPath)
        cell.review = reviewArray?[indexPath.row]
        return cell
    }
}
