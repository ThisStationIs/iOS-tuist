//
//  HomeViewModel.swift
//  HomeFeature
//
//  Created by Muzlive_Player on 2023/12/28.
//  Copyright © 2023 Kkonmo. All rights reserved.
//

import Foundation
import Network

class HomeViewModel {
    var lineInfo: [Lines] = []
    
    public func filterWithReport(to posts: [Post]) -> [Post] {
        return posts.filter { $0.isReported == false }
    }
}

extension HomeViewModel {
    public func getHomeRecentPosts(completion: @escaping (([Post]) -> Void)) {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let endPoint = Endpoint<ResponseWrapper<RecentPosts>>(
            path: "api/v1/home/recent/posts?size=5",
            method: .post,
            bodyParameters: HomePostRequest(userId: userId)
        )
        
        APIServiceManager().request(with: endPoint) { result in
            switch result {
            case .success(let success):
                print("#☀️ success: \(success)")
                completion(success.data.posts)
            case .failure(let failure):
                print("#🌧️ failure: \(failure)")
            }
        }
    }
    
    struct HomePostRequest: Encodable {
        let userId: Int
    }
}

extension HomeViewModel {
    public func getHomeHotPosts() -> Endpoint<ResponseWrapper<RecentPosts>> {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        return Endpoint(
            path: "api/v1/home/hot/posts?size=5",
            method: .post,
            bodyParameters: HomePostRequest(userId: userId)
        )
    }
}

extension HomeViewModel {
    public func getSubwayLine(completion: @escaping (([Lines]) -> ())) {
        // /api/v1/subway/lines
        APIServiceManager().request(with: getLine()) { result in
            switch result {
            case .success(let success):
                self.lineInfo = success.data.lines
                print("### line info is \(success.data)")
                DispatchQueue.main.async {
                    completion(success.data.lines)
                }
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    private func getLine() -> Endpoint<SubwayLineModel> {
        return Endpoint(
            path: "api/v1/subway/lines"
        )
    }
    
    struct SubwayLineModel: Decodable {
        let code: String
        let message: String
        let data: LinesData
    }

    struct LinesData: Decodable {
        let lines: [Lines]
    }
}

extension HomeViewModel {
    func getPostDetail(
        _ postId: Int,
        completion: @escaping ((PostAPIs.DetailPost) -> Void)
    ) {
        let endpoint = PostAPIs.getDetailBoard(id: postId)
        
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                print("### success in getPostDetail is \(success.data)")
                completion(success.data)
            case .failure(let failure):
                print("### failure in getPostDetail is \(failure)")
            }
        }
    }
}

public struct FilterPostsData: Decodable {
    let posts: [Post]
    let totalPages: Int?
    let hasMorePost: Bool
}

public struct Lines: Decodable {
    let id: Int
    let name: String
    let colorCode: String
}

struct RecentPosts: Decodable {
    let posts: [Post]
    private enum CodingKeys: String, CodingKey {
        case posts
    }
}

struct Post: Decodable {
    let postId: Int
    let authorNickname: String
    let subwayLineName: String
    let categoryName: String
    let title: String
    let preview: String
    let commentCount: Int
    let likeCount: Int
    let createdAt: String
    let isReported: Bool
}
