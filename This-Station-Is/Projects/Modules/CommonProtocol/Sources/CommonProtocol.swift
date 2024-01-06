import Foundation
import Network

public struct CommonProtocol {
    public init() {}
}

public protocol Coordinator {
    func start()
}


public class DataManager {
    public static let shared = DataManager()
    
    public var lineInfos: [Line] = []
    public var categoryInfos: [Category] = []
    
    private init() {}
    
    public func getSubwayLine(completion: @escaping (() -> ())) {
        let endpoint = Endpoint<ResponseWrapper<SubwayLinesResponse>> (
            path: "api/v1/subway/lines"
        )
        
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                self.lineInfos = success.data.lines
                completion()
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    struct SubwayLinesResponse: Decodable {
        let lines: [Line]
    }

    public struct Line: Decodable {
        public let id: Int
        public let name: String
        public let colorCode: String
    }
}

extension DataManager {
    /*
     "categorys": [
           {
             "id": 1,
             "name": "연착정보",
             "description": "delay_info"
           },
     */
    public func getCategory(completion: @escaping (() -> ())) {
        let endpoint = Endpoint<ResponseWrapper<CategoryReponses>> (
            path: "api/v1/categorys"
        )
        
        APIServiceManager().request(with: endpoint) { result in
            switch result {
            case .success(let success):
                self.categoryInfos = success.data.categorys
                completion()
            case .failure(let failure):
                print("### failure is \(failure)")
            }
        }
    }
    
    public struct CategoryReponses: Decodable {
        let categorys: [Category]
    }
    
    public struct Category: Decodable {
        public let id: Int
        public let name: String
        public let description: String
    }
}
