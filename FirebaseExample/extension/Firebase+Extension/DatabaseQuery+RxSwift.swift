//
//  DatabaseQuery+RxSwift.swift
//  FirebaseExample
//
//  Created by LEMINHO on 5/10/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

extension DatabaseReference{
    func rx_observeSingleEvent(of event: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create({ (observer) -> Disposable in
            self.observeSingleEvent(of: event, with: { (snapshot) in
                observer.onNext(snapshot)
                observer.onCompleted()
            }, withCancel: { (error) in
                observer.onError(error)
            })
            return Disposables.create()
        })
    }
    
    func rx_observeEvent(event: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create({ (observer) -> Disposable in
            let handle = self.observe(event, with: { (snapshot) in
                observer.onNext(snapshot)
            }, withCancel: { (error) in
                observer.onError(error)
            })
            return Disposables.create {
                self.removeObserver(withHandle: handle)
            }
        })
    }
    
    func rx_setValue(_ arr:[AnyHashable:Any]) -> Observable<Bool>{
        return Observable.create({ (observer) -> Disposable in
            self.setValue(arr,withCompletionBlock: { (error, ref) in
                if(error == nil){
                    // success
                    observer.onNext(true)
                    observer.onCompleted()
                }else{
                    observer.onError(error!)
                }
            })
            return Disposables.create()
        })
    }
}
