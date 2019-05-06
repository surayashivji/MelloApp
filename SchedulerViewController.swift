//
//  SchedulerViewController.swift
//  MelloApp
//
//  Created by Harrison Weinerman on 4/30/19.
//  Copyright © 2019 Suraya Shivji. All rights reserved.
//

import UIKit

class SchedulerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var hourPicker: UIPickerView!
    @IBOutlet weak var minutePicker: UIPickerView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var timeOfDayLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var day1: UILabel!
    @IBOutlet weak var num1: CircleButton!
    
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var num2: CircleButton!
    
    @IBOutlet weak var day3: UILabel!
    @IBOutlet weak var num3: CircleButton!
    
    @IBOutlet weak var day4: UILabel!
    @IBOutlet weak var num4: CircleButton!
    
    @IBOutlet weak var day5: UILabel!
    @IBOutlet weak var num5: CircleButton!
    
    @IBOutlet weak var day6: UILabel!
    @IBOutlet weak var num6: CircleButton!
    
    @IBOutlet weak var day7: UILabel!
    @IBOutlet weak var num7: CircleButton!
    
    @IBOutlet weak var sunday: CircleButton!
    @IBOutlet weak var monday: CircleButton!
    @IBOutlet weak var tuesday: CircleButton!
    @IBOutlet weak var wednesday: CircleButton!
    @IBOutlet weak var thursday: CircleButton!
    @IBOutlet weak var friday: CircleButton!
    @IBOutlet weak var saturday: CircleButton!
    
    @IBOutlet weak var scentLabel: UILabel!
    @IBOutlet weak var scentImageView: UIImageView!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var scent: ScentBlend?
    
    private var weeksAhead = 0
    private let timeStrings = createTimeOptionStrings()
    private let timeOptions = createTimeOptions()
    
    private let durations = [15, 30, 45, 60]
    private var selectedDates = Set<Date>()
    private let today = Date()
    private var startDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scentLabel.text = scent?.name
        scentImageView.image = scent?.image
        startDate = today
        backButton.isHidden = true
        setupDays()
        modalPresentationStyle = .overFullScreen
        cardView.layer.cornerRadius = 30
        cardView.layer.masksToBounds = true
        pickerContainerView.layer.cornerRadius = 20
        pickerContainerView.layer.masksToBounds = true
        hourPicker.delegate = self
        minutePicker.delegate = self
        hourPicker.dataSource = self
        minutePicker.dataSource = self
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func previousWeek(_ sender: Any) {
        startDate = Calendar.current.date(byAdding: DateComponents(day: -7), to: startDate)
        if startDate == today {
            backButton.isHidden = true
        }
        weeksAhead -= 1
        updateWeekData()
    }
    
    @IBAction func nextWeek(_ sender: Any) {
        startDate = Calendar.current.date(byAdding: DateComponents(day: 7), to: startDate)
        backButton.isHidden = false
        weeksAhead += 1
        updateWeekData()
    }
    
    private func updateWeekData() {
        setupDays(startDate)
        weekLabel.text = weekLabel(weeksAhead: weeksAhead)
    }
    
    @IBAction func scheduleTapped(_ sender: Any) {
        let duration = durations[minutePicker.selectedRow(inComponent: 0)]
        let time = timeOptions[hourPicker.selectedRow(inComponent: 0)]
        
        var repeatingDaysOfWeek = [Int]()
        if sunday.isOptionHighlighted { repeatingDaysOfWeek.append(1) }
        if monday.isOptionHighlighted { repeatingDaysOfWeek.append(2) }
        if tuesday.isOptionHighlighted { repeatingDaysOfWeek.append(3) }
        if wednesday.isOptionHighlighted { repeatingDaysOfWeek.append(4) }
        if thursday.isOptionHighlighted { repeatingDaysOfWeek.append(5) }
        if friday.isOptionHighlighted { repeatingDaysOfWeek.append(6) }
        if saturday.isOptionHighlighted { repeatingDaysOfWeek.append(7) }
        
        FirebaseManager.instance.schedule(blend: scent,
                                          time: time,
                                          repeats: repeatingDaysOfWeek,
                                          duration: duration)
        
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "e"
        let singleInstanceBlends = selectedDates.filter({ repeatingDaysOfWeek
            .contains(Int(dayOfWeekFormatter.string(from: $0)) ?? 0 )})
        FirebaseManager.instance.schedule(blend: scent,
                                          dates: Array(singleInstanceBlends),
                                          time: time,
                                          duration: duration)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggled(_ sender: CircleButton) {
        sender.isOptionHighlighted.toggle()
        guard let date = sender.date else { return }
        if sender.isOptionHighlighted {
            selectedDates.insert(date)
        } else {
            selectedDates.remove(date)
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == hourPicker {
            timeOfDayLabel.text = row < 48 ? "AM" : "PM"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hourPicker {
            return timeStrings.count
        } else if pickerView == minutePicker {
            return durations.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        if pickerView == hourPicker {
            return time(for: row)
        } else if pickerView == minutePicker {
            return duration(for: row)
        }
        return nil
    }
    
    func duration(for row: Int) -> NSAttributedString {
        return attributedTitle(String(durations[row]))
    }
    
    func time(for row: Int) -> NSAttributedString {
        return attributedTitle(timeStrings[row])
    }
    
    private func setupDays(_ date: Date? = nil) {
        let date = date ?? today
        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "EEEE"
        let dayNumberFormatter = DateFormatter()
        dayNumberFormatter.dateFormat = "dd"
        let daysOfWeekLabels = [day1, day2, day3, day4, day5, day6, day7]
        let numberLabels = [num1, num2, num3, num4, num5, num6, num7]
        for i in 0...6 {
            guard let nextDate = Calendar.current.date(byAdding: DateComponents(calendar: .current,
                                                                                day: i),
                                                       to: date) else { continue }
            numberLabels[i]?.setTitle(dayNumberFormatter.string(from: nextDate), for: .normal)
            numberLabels[i]?.date = nextDate
            numberLabels[i]?.isOptionHighlighted = selectedDates.contains(nextDate)
            
            daysOfWeekLabels[i]?.text = String(dayOfWeekFormatter.string(from: nextDate).prefix(2))
        }
    }
    
    
    
    private func attributedTitle(_ text: String) -> NSAttributedString {
        return NSAttributedString(string: text,
                                  attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,
                                               NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        
    }
    
    private func weekLabel(weeksAhead: Int) -> String {
        switch weeksAhead {
        case 0: return "This Week"
        case 1: return "Next Week"
        case 2...: return "\(weeksAhead) Weeks From Now"
        default: return ""
        }
    }
    
    private static func createTimeOptionStrings() -> [String] {
        let options = createTimeOptions()
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return options.compactMap({ formatter.string(from: $0) })
    }
    
    private static func createTimeOptions() -> [Date] {
        var options = [Date]()
        var components = DateComponents(calendar: .current, hour: 0, minute: 0)
        
        while components.hour ?? 24 < 24 {
            var minutes = components.minute ?? 30
            var hours = components.hour ?? 22
            
            if let date = Calendar.current.date(from: components) {
                options.append(date)
            }
            
            if minutes != 45 {
                minutes += 15
            } else {
                minutes = 0
                hours += 1
            }
            components = DateComponents(calendar: .current, hour: hours, minute: minutes)
        }
        return options
    }
}
