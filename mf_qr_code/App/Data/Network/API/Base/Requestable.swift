//
//  Requestable.swift
//  Coupon
//
//  Created by Nguyen Quoc Cuong on 11/21/18.
//  Copyright © 2018 Money Forward, Inc. All rights reserved.
//

import RxSwift
import Alamofire
import ObjectMapper

protocol Requestable: URLRequestConvertible {
    
    associatedtype Output
    
    var basePath: String { get }
    
    var endpoint: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var params: Parameters { get }
    
    var defaultHeaders: HTTPHeaders { get }
    
    var additionalHeaders: HTTPHeaders { get }
    
    var parameterEncoding: ParameterEncoding { get }
    
    var statusCode: Range<Int> { get }
    
    var contentType: [String] { get }
    
    var queue: DispatchQueue { get }
    
    func execute() -> Observable<Output>
    
    func decode(data: Any) -> Output
    
}

extension Requestable {
    
    var basePath: String {
        return Constants.APIConfig.baseURLString
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var params: Parameters {
        return [:]
    }
    
    var defaultHeaders: HTTPHeaders {
        return ["Accept": "application/json",
                "Timezone": TimeZone.current.identifier]
    }
    
    var additionalHeaders: HTTPHeaders {
        return [:]
    }

    var urlPath: String {
        return basePath + endpoint
    }
    
    var url: URL {
        return URL(string: urlPath)!
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var statusCode: Range<Int> {
        return 200..<401
    }
    
    var contentType: [String] {
        return ["application/json"]
    }
    
    var queue: DispatchQueue {
        return DispatchQueue.global(qos: .default)
    }
    
    @discardableResult
    func execute() -> Observable<Output> {
        return asObservable()
    }
    
    fileprivate func buildURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval = Constants.APIConfig.timeout
        
        urlRequest = try parameterEncoding.encode(urlRequest, with: params)
        
        defaultHeaders.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        additionalHeaders.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        //urlRequest.addValue(UAManager.UAString(), forHTTPHeaderField: "User-Agent")
        
        return urlRequest
    }
    
    func connectWithRequest(_ urlRequest: URLRequest, complete: @escaping (DataResponse<Any>) -> Void) -> DataRequest {
        let oauthHandler = OAuth2Handler()
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.retrier = oauthHandler
        sessionManager.adapter = oauthHandler
        let request = sessionManager.request(urlRequest)
        
        debugPrint(request)
    
        request.validate(statusCode: statusCode)
        request.validate(contentType: contentType)
        request.responseJSON(queue: queue, completionHandler: { response in
            complete(response)
        })
        
        return request
    }
    
    private func asObservable() -> Observable<Output> {
        return Observable.create { observer in
            guard let urlRequest = try? self.asURLRequest() else {
                observer.onError(NSError.connectServer())
                return Disposables.create()
            }
            
            let connection = self.connectWithRequest(urlRequest, complete: { response in
                if response.result.isSuccess,
                    let data = response.result.value,
                    let responseObjective = Mapper<ResponseEntity<EmptyEntity>>().map(JSONObject: data) {
                    
                    if responseObjective.success ?? false {
                        observer.onNext(self.decode(data: data))
                        observer.onCompleted()
                    } else {
                        observer.onError(NSError.errorWithMessage(
                            responseObjective.errors?.first?.message ?? R.string.localizable.apiErrorInvalidResponseData(),
                            code: NSError.Code.apiErrorCode))
                    }
                } else {
                    observer.onError(NSError.errorWithResponseError(response.error ?? NSError.connectServer()))
                }
            })
            
            return Disposables.create {
                connection.cancel()
            }
        }
    }
}

// MARK: - Conform URLConvertible from Alamofire
extension Requestable {
    
    func asURLRequest() throws -> URLRequest {
        return try buildURLRequest()
    }
    
}
