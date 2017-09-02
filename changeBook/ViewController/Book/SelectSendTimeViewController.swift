//
//  SelectSendTimeViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 27/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class SelectSendTimeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sendTimeBlock: ((String)->())!
    private var dateArray = [String]()
    private var timeArray = [String]()
    private var selectedDateIndex = 0
    private var selectedTimeIndex = 0
    
    private let TAG_DATE: Int = 1
    private let TAG_TIME: Int = 2
    
    private lazy var dateTableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: UITableViewStyle.plain)
        tableView.register(SingleTableViewCell.self, forCellReuseIdentifier: kCellIdSingleTableViewCell)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var timeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SingleTableViewCell.self, forCellReuseIdentifier: kCellIdSingleTableViewCell)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initDatas()
        initSubveiws()
    }
    
    private func initDatas() {
        self.dateArray = [NSDate.getNextData(0), NSDate.getNextData(1), NSDate.getNextData(2), NSDate.getNextData(3), NSDate.getNextData(4)]
        self.timeArray = ["早上 9:30-12:30", "下午3:00-5:00", "晚上7:00-9:00"]
    }
    
    private func initSubveiws() {
        
        self.view.backgroundColor = UIColor.white
        
        self.title = "送货时间"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),NSForegroundColorAttributeName: UIColor.white]
        
        self.contentSizeInPopup = CGSize(width: kScreenWidth, height: SingleTableViewCell.cellHeight() * 5)
        
        self.dateTableView.tag = TAG_DATE
        self.dateTableView.delegate = self
        self.dateTableView.dataSource = self
        self.view.addSubview(self.dateTableView)
        self.dateTableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(kScreenWidth * 0.4)
        }
        
        self.timeTableView.tag = TAG_TIME
        self.timeTableView.delegate = self
        self.timeTableView.dataSource = self
        self.view.addSubview(self.timeTableView)
        self.timeTableView.snp.makeConstraints { (make) in
            make.top.equalTo(SingleTableViewCell.cellHeight())
            make.right.equalTo(0)
            make.left.equalTo(self.dateTableView.snp.right)
            make.bottom.equalTo(-SingleTableViewCell.cellHeight())
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.tag {
        case TAG_DATE:
            return self.dateArray.count
        case TAG_TIME:
            return self.timeArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SingleTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSingleTableViewCell, for: indexPath) as! SingleTableViewCell
        
        switch tableView.tag {
        case TAG_DATE:
            cell.titleLbl.text = self.dateArray[indexPath.row]
            cell.setSelected(selected: (indexPath.row == self.selectedDateIndex))
        case TAG_TIME:
            cell.titleLbl.text = self.timeArray[indexPath.row]
            cell.setSelected(selected: (indexPath.row == self.selectedTimeIndex))
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch tableView.tag {
        case TAG_DATE:
            self.selectedDateIndex = indexPath.row
        case TAG_TIME:
            self.selectedTimeIndex = indexPath.row
        default:
            break
        }
        
        let sendTime = self.dateArray[self.selectedDateIndex] + self.timeArray[self.selectedTimeIndex]
        if nil != self.sendTimeBlock {
            self.sendTimeBlock(sendTime)
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
