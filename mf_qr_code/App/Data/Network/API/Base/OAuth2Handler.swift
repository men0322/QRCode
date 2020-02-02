//
//  OAuth2Handler.swift
//  Coupon
//
//  Created by Nguyen Hung on 11/29/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import Alamofire
import ObjectMapper

class OAuth2Handler: RequestAdapter, RequestRetrier {
    
    private let paramRefreshToken: String = "refresh_token"
    private let acceptKey: String = "Accept"
    private let acceptValue: String = "application/json"
    private let timeZoneKey: String = "Timezone"
    private let authorizationKey: String = "Authorization"
    
    private typealias RefreshCompletion = (_ succeeded: Bool) -> Void
    private let lock = NSLock()
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: configuration)
    }()
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var newUrlRequest = urlRequest
//        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Constant.APIConfig.baseURLString) {
//            if let accessToken = AppSettings.accessToken?.accessToken {
//                newUrlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: authorizationKey)
//            }
//        }
        return newUrlRequest
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        lock.lock(); defer { lock.unlock() }
        
//        guard request.retryCount == 0,
//            !isRefreshing,
//            let response = request.task?.response as? HTTPURLResponse,
//            response.statusCode == 401,
//            let refreshToken = AppSettings.accessToken?.refreshToken else {
//                return completion(false, 0)
//        }
//
//        requestsToRetry.append(completion)
//
//        refreshTokens(refreshToken) { [weak self] succeeded in
//            guard let strongSelf = self else { return }
//            strongSelf.lock.lock(); defer { strongSelf.lock.unlock() }
//            strongSelf.requestsToRetry.forEach { $0(succeeded, 0.0) }
//            strongSelf.requestsToRetry.removeAll()
//        }
    }
    
    private func refreshTokens(_ refreshToken: String, completion: @escaping RefreshCompletion) {
        
//        isRefreshing = true
//
//        let refreshTokenEndPoint = "/oauth/token"
//        let urlString = Constant.APIConfig.baseURLString + refreshTokenEndPoint
//
//        let parameters: [String: Any] = [paramRefreshToken: refreshToken]
//
//        var header = HTTPHeaders()
//        header[acceptKey] = acceptValue
//
//        sessionManager.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header)
//            .responseJSON { [weak self] response in
//
//                guard let strongSelf = self,
//                    let data = response.result.value,
//                    let token = Mapper<API.RefreshTokenOutput>().map(JSONObject: data)?.accessToken
//                    else {
//                        completion(false)
//                        return
//                    }
//
//                AuthManager.shared.save(token)
//
//                completion(true)
//                
//                strongSelf.isRefreshing = false
//            }
    }
}
