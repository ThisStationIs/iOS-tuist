//
//  HomeSearchViewModel.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import Network

class HomeSearchViewModel {
    func saveSearchHistory(_ historys: [String]) {
        let defaults = UserDefaults.standard
        defaults.set(historys, forKey: "SearchHistory")
        
    }
    
    func loadSearchHistory(completion: @escaping (([String]) -> Void)) {
        let defaults = UserDefaults.standard
        let savedHistorys = defaults.object(forKey: "SearchHistory") as? [String] ?? [String]()
        completion(savedHistorys)
    }
}

extension HomeSearchViewModel {
    func getPosts(completion: @escaping (([Post]) -> Void)) {
        let endpoint = Endpoint<ResponseWrapper<RecentPosts>> (
            path: "api/v1/filter/posts"
        )
        
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                print("### success: \(success)")
                completion(success.data.posts)
            case .failure(let failure):
                print("### Failure \(failure)")
            }
        }
    }
}

extension HomeSearchViewModel {
    public func getFilterBoardData(keyword: String, categoryId: Int, subwayLineIds: [String], completion: @escaping (([Post]) -> Void)) {
        APIServiceManager().request(with: getFilterData(keyword: keyword, categoryId: categoryId, subwayLineIds: subwayLineIds)) { result in
            switch result {
            case .success(let success):
                print("board Data : \(success.data.posts)")
                completion(success.data.posts)
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getFilterData(keyword: String, categoryId: Int, subwayLineIds: [String]) -> Endpoint<ResponseWrapper<FilterPostsData>> {
        
        let joinLineIds = subwayLineIds.joined(separator: ",")
        
        // -1 일 경우 전체
        let fileterOptions = FilterOptions(keyword: keyword, categoryId: categoryId == -1 ? "" : "\(categoryId)", subwayLineIds: joinLineIds)
        
        print(fileterOptions)
        
        return Endpoint(
            path: "api/v1/filter/posts",
            queryPrameters: fileterOptions
        )
    }
    
    struct FilterOptions: Encodable {
        let keyword: String
        let categoryId: String
        let subwayLineIds: String
    }
}
