//
//  ViewController.swift
//  FirebaseExample
//
//  Created by LEMINHO on 5/10/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import ObjectMapper
class ViewController: UIViewController {
    let dispo:DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let postRef = Database.database().reference()
            .child("posts").child("ahhhh1001")
        postRef.rx_setValue(["content":"Nice day!!!"] as [AnyHashable:Any])
            .subscribe(onNext:{isUpdate in
                if(isUpdate){
                    print("Update true")
                }else{
                    print("Update false")
                }
            },onError:{error in
                print(error)
            }).disposed(by: dispo)
        let postsRef = Database.database().reference().child("posts")
        postsRef.rx_observeEvent(event: .value)
            .map{ Mapper<Post>().mapArray(snapshot: $0) }
            .subscribe(onNext: { posts in
                //show the data or do whatever you want
                if(posts.count > 0){
                    print("Post content: "+posts[0].content!)
                }
            }, onError: { error in
                //show an alert
                print(error)
            }).disposed(by: dispo)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

