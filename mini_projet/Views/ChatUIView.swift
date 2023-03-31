//
//  ChatUIView.swift
//  mini_projet
//
//  Created by Mac Mini 5 on 30/11/2022.
//

import SwiftUI
import SendbirdUIKit

struct ChatUIView: View {
    init() {
           
           // 1. Initialize Sendbird UIKit
        SendbirdUI.initialize(applicationId: "E8E24064-1528-4531-8964-727C6DEF7518") { // This is the origin.
            // Initialization of SendbirdUIKit has started.
            // Show a loading indicator.
        } migrationHandler: {
            // DB migration has started.
        } completionHandler: { error in
            // If DB migration is successful, proceed to the next step.
            // If DB migration fails, an error exists.
            // Hide the loading indicator.
        }
           // 2. Set the current user
        SBUGlobals.currentUser = SBUUser(userId: "a5013b89196456685639972b24fe8deec141327c")

           // 3. Connect to Sendbird
        SendbirdUI.connect { (user, error) in
               
               // user object will be an instance of SBDUser
               guard let _ = user else {
                   print("ContentView: init: Sendbird connect: ERROR: \(String(describing: error)). Check applicationId")
                   return
               }
           }
       }
       
       var body: some View {
           // 4. Call up the custom Channel List
           ChannelListViewContainer()
       }
    
}

/*
 struct ChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatUIView()
    }
 */

