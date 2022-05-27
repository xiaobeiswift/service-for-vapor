//
//  File.swift
//  
//
//  Created by 孟祥文 on 2022/5/27.
//
import Vapor
protocol ServiceFactory {
    var req: Request { get }
}

extension ServiceFactory {
    public func make(_ id: String) -> RequestService {
        req.application.services.get(id, for: req)
    }
    
    public func make<T>(id: String) -> T {
         guard let result = make(id) as? T else {
             fatalError("\(id) is not configured,use: app.services.use()")
         }
         return result
    }
}
