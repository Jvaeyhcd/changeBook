//
//  ChatViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 12/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//  单聊界面不考虑群聊的情况

import UIKit

class ChatViewController: EaseMessageViewController, EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource, CacheProtocol {

    var selectedCallback: EaseSelectAtTargetCallback!
    var userName = ""
    var nickName = ""
    var headPic = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showRefreshHeader = true
        self.delegate = self
        self.dataSource = self
        self.showBackButton()
        self.title = self.nickName
        self.tableView.reloadData()
    }
    
    deinit {
        EMClient.shared().removeDelegate(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - EaseMessageViewControllerDelegate
    
    func messageViewController(_ tableView: UITableView!, cellFor messageModel: IMessageModel!) -> UITableViewCell! {
        
        let CellIdentifier = EaseMessageCell.cellIdentifier(withModel: messageModel)
        
        var sendCell: EaseBaseMessageCell?
        sendCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier!) as? EaseBaseMessageCell
        
        // Configure the cell...
        if (sendCell == nil) {
            sendCell = EaseBaseMessageCell.init(style: .default, reuseIdentifier: CellIdentifier, model: messageModel)
            sendCell?.selectionStyle = .none
        }
        
        sendCell?.model = messageModel
        return sendCell
        
    }
    
    func messageViewController(_ viewController: EaseMessageViewController!, heightFor messageModel: IMessageModel!, withCellWidth cellWidth: CGFloat) -> CGFloat {
        return EaseBaseMessageCell.cellHeight(withModel: messageModel)
    }
    
    func messageViewController(_ viewController: EaseMessageViewController!, canLongPressRowAt indexPath: IndexPath!) -> Bool {
        return true
    }
    
    func messageViewController(_ viewController: EaseMessageViewController!, didLongPressRowAt indexPath: IndexPath!) -> Bool {
        let object = self.dataArray.object(at: indexPath.row)
        if !(object is NSString) {
            let cell = tableView.cellForRow(at: indexPath) as! EaseMessageCell
            cell.becomeFirstResponder()
            self.menuIndexPath = indexPath
            self.showMenuViewController(cell.bubbleView, andIndexPath: indexPath, messageType: cell.model.bodyType)
        }
        return true
    }
    
    func messageViewController(_ viewController: EaseMessageViewController!, didSelectAvatarMessageModel messageModel: IMessageModel!) {
        // 点击消息头像
    }
    
    
    // MARK: - EaseMessageViewControllerDataSource
    func messageViewController(_ viewController: EaseMessageViewController!, modelFor message: EMMessage!) -> IMessageModel! {
        
        let model = EaseMessageModel.init(message: message)
        let (headPic, nickName) = getUserInfoByMessage(message: message)
        model?.nickname = nickName
        model?.avatarURLPath = headPic
        return model
    }
    
    private func getUserInfoByMessage(message: EMMessage) -> (headPic: String, nickName: String) {
        
        let headPic = ""
        let nickName = ""
        
        if nil == conversation.latestMessage {
            return (headPic, nickName)
        }
        
        var user: User?
        user = getCacheUser(userName: message.from.uppercased())
        
        if nil != user {
            return ((user?.headPic)!, (user?.nickName)!)
        } else {
            let lastExt = message.ext
            var headPic = ""
            var nickName = ""
            if nil != lastExt && nil != lastExt?[USER_HEAD_IMG] && nil != lastExt?[USER_NAME] {
                headPic = (lastExt?[USER_HEAD_IMG] as? String)!
                nickName = (lastExt?[USER_NAME] as? String)!
            }
            
            if headPic != "" && nickName != "" {
                return (headPic, nickName)
            }
            
            return (sharedGlobal.getSavedUser().headPic, sharedGlobal.getSavedUser().nickName)
        }
    }
    
    func emotionFormessageViewController(_ viewController: EaseMessageViewController!) -> [Any]! {
        let emotions = NSMutableArray.init()
        for n in EaseEmoji.allEmoji() {
            let name = n as! String
            let emotion: EaseEmotion = EaseEmotion.init(name: "", emotionId: name, emotionThumbnail: name, emotionOriginal: name, emotionOriginalURL: "", emotionType: EMEmotionType.default)
            emotions.add(emotion)
        }
        let temp: EaseEmotion = emotions.object(at: 0) as! EaseEmotion
        let managerDefault: EaseEmotionManager = EaseEmotionManager.init(type: EMEmotionType.default, emotionRow: 3, emotionCol: 7, emotions: emotions as! [Any], tagImage: UIImage(named: temp.emotionId))
        
        return [managerDefault]
    }
    
    func isEmotionMessageFormessageViewController(_ viewController: EaseMessageViewController!, messageModel: IMessageModel!) -> Bool {
        return false
    }
    
    override func _send(_ message: EMMessage!) {
        var dic = [String: String]()
       
        dic[USER_HEAD_IMG] = sharedGlobal.getSavedUser().headPic
        dic[USER_NAME] = sharedGlobal.getSavedUser().nickName
        
        message.ext = dic
        self.addMessage(toDataSource: message, progress: nil)
        EMClient.shared().chatManager.send(message, progress: nil) { (aMessage, aError) in
            if let _ = aError {
                self._refresh(afterSentMessage: aMessage)
            }else {
                self.tableView.reloadData()
            }
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
