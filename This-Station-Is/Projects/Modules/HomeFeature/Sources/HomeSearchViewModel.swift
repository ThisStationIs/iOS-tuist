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
    func getPosts() -> Endpoint<ResponseWrapper<RecentPosts>> {
        return Endpoint(
            path: "api/v1/posts?size=10"
        )
    }
}
