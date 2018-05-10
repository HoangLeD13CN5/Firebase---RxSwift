//
//  AppInitializeManager.swift
//  FirebaseExample
//
//  Created by LEMINHO on 5/10/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import RxSwift
import Firebase

class AppInitializeManager{
    static let instance = AppInitializeManager()
    let dispos = DisposeBag()
    // init firebase and login
    private init(){
        
    }
    
    func prepare(_ application:UIApplication,callback:@escaping () -> Void){
        Observable<Void>.create{ e in
            FirebaseApp.configure()
            e.onCompleted()
            return Disposables.create()
        }
        .flatMap{_ in
            return Auth.auth().rx.signIn(withEmail: "hoanglm@ominext.com", password: "01659544034")
        }
        .subscribe(onNext: {
                
        },
        onError:{ error in
            print("AppInitializeManager: \(error)")
        },onCompleted:{
            print("AppInitializeManager: success")
            callback()
        })
        .disposed(by: dispos)
    }
}
