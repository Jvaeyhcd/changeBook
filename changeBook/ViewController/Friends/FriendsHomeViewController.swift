//
//  FriendsHomeViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 23/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class FriendsHomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, EMChatManagerDelegate, CacheProtocol {

    var conversations =  [EMConversation]()
    var currentUsername = EMClient.shared().currentUsername
    
    lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: .zero, style: .plain)
        tableView.register(ConversationListTableViewCell.self, forCellReuseIdentifier: kCellIdConversationListTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
        reloadData()
    }
    
    private func initSubviews() {
        
        self.title = "书友"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-kTabBarHeight)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EMClient.shared().chatManager.add(self, delegateQueue: nil)
    }
    
    private func reloadData() {
        
        if self.conversations.count > 0 {
            self.conversations.removeAll()
        }
        
        let conversations =  EMClient.shared().chatManager.getAllConversations() as! [EMConversation]
        for conversation in conversations {
            if conversation.latestMessage != nil {
                self.conversations.append(conversation)
            }
        }
        
        self.updateConversations()
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdConversationListTableViewCell, for: indexPath) as! ConversationListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding)
        
        let conversation = self.conversations[indexPath.row]
        
        let (content, time) = lastMessageInfoByConversation(conversation: conversation)
        cell.contentLbl.text = content
        cell.timeLbl.text = time
        
        let (headPic, nickName) = getUserInfoByConversation(conversation: conversation)
        cell.titleLbl.text = nickName
        cell.headImg.sd_setImage(with: URL.init(string: headPic), placeholderImage: kNoImgDefaultImage)
        cell.setBadge(badge: Int(conversation.unreadMessagesCount))
        
        return cell
    }
    
    private func getUserInfoByConversation(conversation: EMConversation) -> (headPic: String, nickName: String) {
        
        var headPic = ""
        var nickName = ""
        
        if nil == conversation.latestMessage {
            return (headPic, nickName)
        }
        
        var user: User?
        if conversation.latestMessage.to != sharedGlobal.getSavedUser().userName {
            user = getCacheUser(userName: conversation.latestMessage.to)
        } else if conversation.latestMessage.from != sharedGlobal.getSavedUser().userName {
            user = getCacheUser(userName: conversation.latestMessage.from)
        } else if conversation.latestMessage.from == sharedGlobal.getSavedUser().userName && conversation.latestMessage.to == sharedGlobal.getSavedUser().userName {
            user = getCacheUser(userName: conversation.latestMessage.from)
        }
        
        if nil != user {
            return ((user?.headPic)!, (user?.nickName)!)
        }
        
        if nil != conversation.ext && nil != conversation.ext[USER_HEAD_IMG] && nil != conversation.ext[USER_NAME]{
            headPic = conversation.ext[USER_HEAD_IMG] as! String
            nickName = conversation.ext[USER_NAME] as! String
        }
        
        if "" == headPic && "" == nickName {
            let lastMessage = conversation.latestMessage
            let lastExt = lastMessage?.ext
            if nil != lastExt && nil != lastExt?[USER_HEAD_IMG] && nil != lastExt?[USER_NAME] {
                headPic = (lastExt?[USER_HEAD_IMG] as? String)!
                nickName = (lastExt?[USER_NAME] as? String)!
            }
            
        }
        return (headPic, nickName)
    }
    
    private func lastMessageInfoByConversation(conversation: EMConversation) -> (content: String, time: String) {
        var ret: String = ""
        var time: String = ""
        
        if let lastMessage: EMMessage = conversation.latestMessage {
            if let messageBody: EMMessageBody = lastMessage.body {
                switch messageBody.type {
                case EMMessageBodyTypeText:
                    let didReceiveText = EaseConvertToCommonEmoticonsHelper.convert(toSystemEmoticons: (messageBody as! EMTextMessageBody).text)
                    ret = didReceiveText!
                    break
                case EMMessageBodyTypeImage:
                    ret = "[图片]"
                    break
                case EMMessageBodyTypeVideo:
                    ret = "[小视频]"
                    break
                case EMMessageBodyTypeLocation:
                    ret = "[地址]"
                    break
                case EMMessageBodyTypeVoice:
                    ret = "[语音]"
                    break
                default:
                    break
                }
            }
            time = NSDate.formattedTime(fromTimeInterval: lastMessage.timestamp)
        }
        return (ret, time)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ConversationListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let conversation = self.conversations[indexPath.row]
        let (headPic, nickName) = getUserInfoByConversation(conversation: conversation)
        
        var user: User!
        if conversation.latestMessage.to != sharedGlobal.getSavedUser().userName {
            user = getCacheUser(userName: conversation.latestMessage.to)
        } else if conversation.latestMessage.from != sharedGlobal.getSavedUser().userName {
            user = getCacheUser(userName: conversation.latestMessage.from)
        } else if conversation.latestMessage.from == sharedGlobal.getSavedUser().userName && conversation.latestMessage.to == sharedGlobal.getSavedUser().userName {
            self.showHudTipStr("不能自己和自己聊天")
            user = nil
        }
        
        if nil != user {
            let vc = ChatViewController.init(conversationChatter: conversation.latestMessage.from, conversationType: EMConversationTypeChat)
            vc?.nickName = user.nickName
            vc?.headPic = user.headPic
            vc?.userName = user.userName
            vc?.hidesBottomBarWhenPushed = true
            self.pushViewController(viewContoller: vc!, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction.init(style: .default, title: "删除") { (action, indexPath) in
            
        }
        return [deleteAction]
    }
    
    // MARK: - EMChatManagerDelegate
    func conversationListDidUpdate(_ aConversationList: [Any]!) {
        self.reloadData()
    }

    func messageStatusDidChange(_ aMessage: EMMessage!, error aError: EMError!) {
        self.reloadData()
    }
    
    func messagesDidReceive(_ aMessages: [Any]!) {
        self.reloadData()
    }
    
    // MARK: - private
    private func updateConversations() {
        let conversations = EMClient.shared().chatManager.getAllConversations()
        var unreadCount: Int32 = 0
        for conversation in conversations! {
            let con = conversation as! EMConversation
            unreadCount = unreadCount + con.unreadMessagesCount
        }
        if unreadCount > 99 {
            self.navigationController?.tabBarItem.badgeValue = "99+"
        } else if unreadCount > 0 {
            self.navigationController?.tabBarItem.badgeValue = "\(unreadCount)"
        } else {
            self.navigationController?.tabBarItem.badgeValue = ""
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        EMClient.shared().chatManager.remove(self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
