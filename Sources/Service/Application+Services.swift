//
//  File.swift
//  
//
//  Created by 孟祥文 on 2022/5/27.
//

import Vapor

extension Application {
    public struct Services {
        public struct Provider {
            public init(_ run: @escaping (Application) -> ()) {
                self.run = run
            }
            
            let run: (Application) -> ()
        }
        
        final class Storage {
            var member:[String:(Request)-> RequestService] = [:]
        }
        
        struct Key: StorageKey {
            typealias Value = Storage
        }
        
        let app: Application
        
        public func use(_ provider: Provider) {
            provider.run(app)
        }
        var storage: Storage {
            if app.storage[Key.self] == nil {
                app.storage[Key.self] = .init()
            }
            
            return app.storage[Key.self]!
        }
        
        public func use(_ id: String,make: @escaping (Request) -> RequestService) {
            storage.member[id] = make
        }
        
        func get(_ id: String,for req: Request) -> RequestService {
            guard let make = storage.member[id] else {
                fatalError("Service not configured, use: app.services.use(_ id:)")
            }
            return make(req)
        }
    }
    
    public var services: Services {
        .init(app: self)
    }
}
