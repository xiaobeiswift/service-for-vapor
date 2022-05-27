//
//  File.swift
//  
//
//  Created by 孟祥文 on 2022/5/27.
//

import Vapor

extension Request {
    // repository
    public struct RepositoryFactory: ServiceFactory {
        let req: Request
        
        fileprivate init(_ req:Request) {
            self.req = req
        }
        
        public func make<T>(id: String) -> T {
            make(id: id, for: req)
        }
    }
    private struct RepositoryFactoryKey: StorageKey {
        typealias Value = RepositoryFactory
    }
    
    public var repositories: RepositoryFactory {
        get {
            self.application.storage[RepositoryFactoryKey.self] ?? .init(self)
        }
        set {
            self.application.storage[RepositoryFactoryKey.self] = newValue
        }
    }
    
    //services
    public struct ServicesFactory: ServiceFactory {
        let req: Request
        
        fileprivate init(_ req:Request) {
            self.req = req
        }
        public func make<T>(id: String) -> T {
            make(id: id, for: req)
        }
    }
    private struct ServicesFactoryKey: StorageKey {
        typealias Value = ServicesFactory
    }
    
    public var services: ServicesFactory{
        get {
            self.application.storage[ServicesFactoryKey.self] ?? .init(self)
        }
        set {
            self.application.storage[ServicesFactoryKey.self] = newValue
        }
    }
    
    // ApiServices
    
    public struct ApiServicesFactory: ServiceFactory {
        let req: Request
        
        fileprivate init(_ req:Request) {
            self.req = req
        }
        public func make<T>(id: String) -> T {
            make(id: id, for: req)
        }
    }
    private struct ApiServicesFactoryKey: StorageKey {
        typealias Value = ApiServicesFactory
    }
    
    public var apis: ApiServicesFactory {
        get {
            self.application.storage[ApiServicesFactoryKey.self] ?? .init(self)
        }
        set {
            self.application.storage[ApiServicesFactoryKey.self] = newValue
        }
    }
}
