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
