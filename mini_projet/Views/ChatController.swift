//
//  ChatController.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 28/11/2022.
//

import SwiftUI
import SendbirdUIKit
import SendbirdChatSDK



class ChannelListViewController: SBUGroupChannelListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerComponent?.rightBarButton = nil
        self.headerComponent?.leftBarButton = nil
        
        let listQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        
        listQuery?.userIdsExactFilter = [UserDefaults.standard.string(forKey: "_id")!]
        listQuery?.loadNextPage(completionHandler: { (groupChannels, error) in
         //  print("groupe channel : ",groupChannels, "erreur : ",error)
            guard error == nil else {return}
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       
    }
    /*
    // 3a. Create a UINavigationController with the Sendbird channel list
    //     view controller as it's root view controller
    @objc
    func displaySendbirdChanelList(){
        let clvc = SBUGroupChannelListViewController()
        let navc = UINavigationController(rootViewController: clvc)
        navc.title = "AESTHETIC"
        navc.modalPresentationStyle = .fullScreen
        present(navc, animated: true)
    }
    
    // 3b. Present the UINavigationController above
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displaySendbirdChanelList()
    }
}

// 4. Create a UIViewControllerRepresentable struct
struct ChannelListViewContainer: UIViewControllerRepresentable {
    
    // 4a. Set the typealias to the class in step 3
    typealias UIViewControllerType = ChannelListViewController
    
    // 4b. Have the makeUIViewController return an instance of the class from step 3
    func makeUIViewController(context: Context) -> ChannelListViewController {
        return ChannelListViewController()
    }
    
    // 4c. Add the required updateUIViewController function
    func updateUIViewController(_ uiViewController: ChannelListViewController, context: Context) {
    }*/
}

