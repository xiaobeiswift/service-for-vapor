//
//  File.swift
//  
//
//  Created by 孟祥文 on 2022/5/27.
//
import Vapor
public protocol ServiceFactory {
}

extension ServiceFactory {
    public func make(_ id: String,for req: Request) -> RequestService {
        req.application.services.get(id, for: req)
    }
    
    public func make<T>(id: String,for req: Request) -> T {
         guard let result = make(id,for: req) as? T else {
             fatalError("\(id) is not configured,use: app.services.use()")
         }
         return result
    }
}
