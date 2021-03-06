//
//  ScheduleDetailRecordPlayerViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 5..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ScheduleDetailRecordPlayerViewController: UIViewController {

    // MARK: Properites
    
    var sid: String!
    var pid: String!
    var player: HBPlayer!
    var record: HBRecord?
    
    var batterRecord = HBBatterRecord()
    var pitcherRecord = HBPitcherRecord()
    
    var batterRecords = [Int]()
    var pitcherRecords = [Int]()
    var inning: Double = 0.0 {
        didSet {
            if Int(inning * 10.0) % 10 == 3 {
                inning -= 0.3
                inning += 1.0
            } else if Int(inning * 10.0) % 10 == 9 {
                inning -= 0.7
            }
        }
    }
    
    var buttonHold = false
    
    @IBOutlet private var scheduleDetailRecordPlayerHeaderView: ScheduleDetailRecordPlayerHeaderView!
    private let cellReuseIdendifier = "recordPlayerCell"
    
    @IBOutlet var tableView: UITableView!
    
    private lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(
            x: 0.0,
            y: 0.0,
            width: self.view.frame.size.width,
            height: 50.0))
        footerView.backgroundColor = .white
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        return footerView
    }()
    
    // MARK: Methods
    
    private func createRecord() -> HBRecord {
        batterRecord.singleHit = batterRecords[0]
        batterRecord.doubleHit = batterRecords[1]
        batterRecord.tripleHit = batterRecords[2]
        batterRecord.homeRun = batterRecords[3]
        batterRecord.baseOnBalls = batterRecords[4]
        batterRecord.hitByPitch = batterRecords[5]
        batterRecord.sacrificeHit = batterRecords[6]
        batterRecord.stolenBase = batterRecords[7]
        batterRecord.strikeOut = batterRecords[8]
        batterRecord.groundBall = batterRecords[9]
        batterRecord.flyBall = batterRecords[10]
        batterRecord.run = batterRecords[11]
        batterRecord.RBI = batterRecords[12]
        
        pitcherRecord.win = pitcherRecords[0]
        pitcherRecord.lose = pitcherRecords[1]
        pitcherRecord.hold = pitcherRecords[2]
        pitcherRecord.save = pitcherRecords[3]
        inning = round(inning * 10.0) / 10.0
        pitcherRecord.inning = inning
        pitcherRecord.strikeOuts = pitcherRecords[5]
        pitcherRecord.ER = pitcherRecords[6]
        pitcherRecord.hits = pitcherRecords[7]
        pitcherRecord.homeRuns = pitcherRecords[8]
        pitcherRecord.walks = pitcherRecords[9]
        pitcherRecord.hitBatters = pitcherRecords[10]
        
        let record = HBRecord(batterRecord: batterRecord, pitcherRecord: pitcherRecord)
        return record
    }
    
    @objc private func cancelButtonDidTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "cancelToDetailView", sender: self)
    }
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
        let record = createRecord()
        
        guard let currnetUser = Auth.auth().currentUser else { return }
        let ref = Database.database().reference()

        CloudFunction.getUserDataWith(currnetUser) {
            (user, error) -> Void in

            if let user = user {
                let teamRef = ref.child("schedules").child(user.teamCode)
                teamRef.child(self.sid).child("records").child(self.pid).setValue(
                    ["singleHit": record.batterRecord.singleHit,
                     "doubleHit": record.batterRecord.doubleHit,
                     "tripleHit": record.batterRecord.tripleHit,
                     "homeRun": record.batterRecord.homeRun,
                     "baseOnBalls": record.batterRecord.baseOnBalls,
                     "hitByPitch": record.batterRecord.hitByPitch,
                     "sacrificeHit": record.batterRecord.sacrificeHit,
                     "stolenBase": record.batterRecord.stolenBase,
                     "strikeOut": record.batterRecord.strikeOut,
                     "groundBall": record.batterRecord.groundBall,
                     "flyBall": record.batterRecord.flyBall,
                     "run": record.batterRecord.run,
                     "RBI": record.batterRecord.RBI,
                     "win": record.pitcherRecord.win,
                     "lose": record.pitcherRecord.lose,
                     "hold": record.pitcherRecord.hold,
                     "save": record.pitcherRecord.save,
                     "inning": record.pitcherRecord.inning,
                     "strikeOuts": record.pitcherRecord.strikeOuts,
                     "ER": record.pitcherRecord.ER,
                     "hits": record.pitcherRecord.hits,
                     "homeRuns": record.pitcherRecord.homeRuns,
                     "walks": record.pitcherRecord.walks,
                     "hitBatters": record.pitcherRecord.hitBatters])
            }
        }
        
        sleep(1)
        self.performSegue(withIdentifier: "unwindToDetailView", sender: self)
    }
    
    @objc private func batterButtonDidTapped(_ sender: UIButton) {
        scheduleDetailRecordPlayerHeaderView.batterButtonState = true
        
        self.tableView.reloadData()
        self.tableView.scrollToRow(
            at: IndexPath(row: 0, section: 0),
            at: .top,
            animated: true)
    }
    
    @objc private func pitcherButtonDidTapped(_ sender: UIButton) {
        scheduleDetailRecordPlayerHeaderView.batterButtonState = false
        
        self.tableView.scrollToRow(
            at: IndexPath(row: 0, section: 0),
            at: .top,
            animated: true)
        self.tableView.reloadData()
    }
    
    @objc private func minusImageViewDidTapped(_ sender: UITapGestureRecognizer) {
        guard let minusImageView = sender.view as? UIImageView else { return }
        if let cell = minusImageView.superview as? ScheduleDetailRecordPlayerTableViewCell {
            let row = minusImageView.tag
            
            if scheduleDetailRecordPlayerHeaderView.batterButtonState {
                if batterRecords[row] > 0 {
                    batterRecords[row] -= 1
                }
                cell.recordLabel.text = "\(batterRecords[row])"
            } else {
                if row == 4 {
                    if inning > 0.0 {
                        inning -= 0.1
                    }
                    
                    let inningReminder = Int(inning * 10.0) % 10
                    if inningReminder == 0 {
                        cell.recordLabel.text = "\(Int(inning))"
                    } else {
                        cell.recordLabel.text = "\(Int(inning)) \(inningReminder)/3"
                    }
                } else {
                    if pitcherRecords[row] > 0 {
                        pitcherRecords[row] -= 1
                    }
                    cell.recordLabel.text = "\(pitcherRecords[row])"
                }
                
                for index in 0...3 {
                    if index == row {
                        buttonHold = false
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc private func plusImageViewDidTapped(_ sender: UITapGestureRecognizer) {
        guard let plusImageView = sender.view as? UIImageView else { return }
        if let cell = plusImageView.superview as? ScheduleDetailRecordPlayerTableViewCell {
            let row = plusImageView.tag
            
            if scheduleDetailRecordPlayerHeaderView.batterButtonState {
                batterRecords[row] += 1
                
                cell.recordLabel.text = "\(batterRecords[row])"
            } else {
                if row == 4 {
                    inning += 0.1
                    
                    let inningReminder = Int(inning * 10.0) % 10
                    if inningReminder == 0 {
                        cell.recordLabel.text = "\(Int(inning))"
                    } else {
                        cell.recordLabel.text = "\(Int(inning)) \(inningReminder)/3"
                    }
                } else {
                    pitcherRecords[row] += 1
                    cell.recordLabel.text = "\(pitcherRecords[row])"
                }
                
                for index in 0...3 {
                    if index == row {
                        buttonHold = true
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(
            ScheduleDetailRecordPlayerTableViewCell.self,
            forCellReuseIdentifier: cellReuseIdendifier)
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        self.tableView.tableFooterView = footerView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        scheduleDetailRecordPlayerHeaderView.name = player.name
        
        scheduleDetailRecordPlayerHeaderView.cancelButton.addTarget(
            self,
            action: #selector(cancelButtonDidTapped(_:)),
            for: .touchUpInside)
        scheduleDetailRecordPlayerHeaderView.doneButton.addTarget(
            self,
            action: #selector(doneButtonDidTapped(_:)),
            for: .touchUpInside)
        
        scheduleDetailRecordPlayerHeaderView.batterButton.addTarget(
            self,
            action: #selector(batterButtonDidTapped(_:)),
            for: .touchUpInside)
        scheduleDetailRecordPlayerHeaderView.pitcherButton.addTarget(
            self,
            action: #selector(pitcherButtonDidTapped(_:)),
            for: .touchUpInside)
        
        for index in 0...12 {
            if let record = record {
                switch index {
                case 0: batterRecords.append(record.batterRecord.singleHit)
                case 1: batterRecords.append(record.batterRecord.doubleHit)
                case 2: batterRecords.append(record.batterRecord.tripleHit)
                case 3: batterRecords.append(record.batterRecord.homeRun)
                case 4: batterRecords.append(record.batterRecord.baseOnBalls)
                case 5: batterRecords.append(record.batterRecord.hitByPitch)
                case 6: batterRecords.append(record.batterRecord.sacrificeHit)
                case 7: batterRecords.append(record.batterRecord.stolenBase)
                case 8: batterRecords.append(record.batterRecord.strikeOut)
                case 9: batterRecords.append(record.batterRecord.groundBall)
                case 10: batterRecords.append(record.batterRecord.flyBall)
                case 11: batterRecords.append(record.batterRecord.run)
                case 12: batterRecords.append(record.batterRecord.RBI)
                default: break
                }
            } else {
                batterRecords.append(0)
            }
        }
        
        for index in 0...11 {
            if let record = record {
                switch index {
                case 0: pitcherRecords.append(record.pitcherRecord.win)
                case 1: pitcherRecords.append(record.pitcherRecord.lose)
                case 2: pitcherRecords.append(record.pitcherRecord.hold)
                case 3: pitcherRecords.append(record.pitcherRecord.save)
                case 4:
                    pitcherRecords.append(-1)
                    inning = record.pitcherRecord.inning
                case 5: pitcherRecords.append(record.pitcherRecord.strikeOuts)
                case 6: pitcherRecords.append(record.pitcherRecord.ER)
                case 7: pitcherRecords.append(record.pitcherRecord.hits)
                case 8: pitcherRecords.append(record.pitcherRecord.homeRuns)
                case 9: pitcherRecords.append(record.pitcherRecord.walks)
                case 10: pitcherRecords.append(record.pitcherRecord.hitBatters)
                default: break
                }
                
                if record.pitcherRecord.win == 1 { buttonHold = true }
                if record.pitcherRecord.lose == 1 { buttonHold = true }
                if record.pitcherRecord.hold == 1 { buttonHold = true }
                if record.pitcherRecord.save == 1 { buttonHold = true }
            } else {
                switch index {
                case 4: pitcherRecords.append(-1)
                default: pitcherRecords.append(0)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.view.isOpaque = false
        
        self.view.frame.origin.y = self.view.bounds.origin.y + 50.0
    }
}

extension ScheduleDetailRecordPlayerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scheduleDetailRecordPlayerHeaderView.batterButtonState {
            return 13
        } else {
            return 11
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier,
            for: indexPath) as! ScheduleDetailRecordPlayerTableViewCell
        
        let minusTapRecognizer = UITapGestureRecognizer()
        minusTapRecognizer.addTarget(self, action: #selector(minusImageViewDidTapped(_:)))
        cell.minusImageView.tag = indexPath.row
        cell.minusImageView.isUserInteractionEnabled = true
        cell.minusImageView.addGestureRecognizer(minusTapRecognizer)
        
        let plusTapRecognizer = UITapGestureRecognizer()
        plusTapRecognizer.addTarget(self, action: #selector(plusImageViewDidTapped(_:)))
        cell.plusImageView.tag = indexPath.row
        cell.plusImageView.isUserInteractionEnabled = true
        cell.plusImageView.addGestureRecognizer(plusTapRecognizer)
        
        if scheduleDetailRecordPlayerHeaderView.batterButtonState {
            cell.recordLabel.text = "\(batterRecords[indexPath.row])"
            
            switch indexPath.row {
            case 0:
                cell.headText = "1루타"
                cell.imageViewEnabled()
            case 1:
                cell.headText = "2루타"
                cell.imageViewEnabled()
            case 2:
                cell.headText = "3루타"
                cell.imageViewEnabled()
            case 3:
                cell.headText = "홈런"
                cell.imageViewEnabled()
            case 4: cell.headText = "볼넷"
            case 5: cell.headText = "사구"
            case 6: cell.headText = "희생타"
            case 7: cell.headText = "도루"
            case 8: cell.headText = "삼진"
            case 9: cell.headText = "땅볼"
            case 10: cell.headText = "뜬공"
            case 11: cell.headText = "득점"
            case 12: cell.headText = "타점"
            default: break
            }
        } else {
            switch indexPath.row {
            case 4:
                let inningReminder = Int(inning * 10.0) % 10
                if inningReminder == 0 {
                    cell.recordLabel.text = "\(Int(inning))"
                } else {
                    cell.recordLabel.text = "\(Int(inning)) \(inningReminder)/3"
                }
            default:
                cell.recordLabel.text = "\(pitcherRecords[indexPath.row])"
            }
            
            switch indexPath.row {
            case 0: cell.headText = "승리"
            case 1: cell.headText = "패배"
            case 2: cell.headText = "홀드"
            case 3: cell.headText = "세이브"
            case 4: cell.headText = "이닝"
            case 5: cell.headText = "삼진"
            case 6: cell.headText = "자책점"
            case 7: cell.headText = "피안타"
            case 8: cell.headText = "피홈런"
            case 9: cell.headText = "볼넷"
            case 10: cell.headText = "사구"
            default: break
            }
            
            // pitcher button state
            switch indexPath.row {
            case 0:
                if buttonHold {
                    if pitcherRecords[0] == 1 {
                        cell.plusImageView.alpha = 0.5
                        cell.plusImageView.isUserInteractionEnabled = false
                    } else { cell.imageViewDisabled() }
                } else { cell.imageViewEnabled() }
            case 1:
                if buttonHold {
                    if pitcherRecords[1] == 1 {
                        cell.plusImageView.alpha = 0.5
                        cell.plusImageView.isUserInteractionEnabled = false
                    } else { cell.imageViewDisabled() }
                } else { cell.imageViewEnabled() }
            case 2:
                if buttonHold {
                    if pitcherRecords[2] == 1 {
                        cell.plusImageView.alpha = 0.5
                        cell.plusImageView.isUserInteractionEnabled = false
                    } else { cell.imageViewDisabled() }
                } else { cell.imageViewEnabled() }
            case 3:
                if buttonHold {
                    if pitcherRecords[3] == 1 {
                        cell.plusImageView.alpha = 0.5
                        cell.plusImageView.isUserInteractionEnabled = false
                    } else { cell.imageViewDisabled() }
                } else { cell.imageViewEnabled() }
            default: cell.imageViewEnabled()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 104.5/736).rounded()
    }
}
