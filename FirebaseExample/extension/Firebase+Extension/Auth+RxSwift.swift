//
//  FirAuth+RxSwift.swift
//  FirebaseExample
//
//  Created by LEMINHO on 5/10/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

// MARK: - Sign in
extension Reactive where Base: Auth {
    
    public func signIn(withEmail email: String, password: String) -> Observable<Void> {
        return .create { observer in
            self.base.signIn(withEmail: email, password: password) { (user, error) in
                if(error != nil){
                    observer.onError(error!)
                }else{
                print("Email: "+(user?.email)!)
                 observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    
}
