//
//  SetReminderViewController.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/5/22.
//

import UIKit
import EventKit

class SetReminderViewController: UIViewController {
    
    public var storeName: String?
    private var store = EKEventStore()

    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /* Help taken from https://nemecek.be/blog/35/how-to-create-ios-reminders-in-code-with-alarms-or-recurrences
      to understand how to set reminders */
    @IBAction func setReminderPressed(_ sender: UIButton) {
        store.requestAccess(to: .reminder) { (granted, error) in
            if let error = error {
                print(error)
                return
            }

            if granted {
                if let name = self.storeName{
                    // Set a reminder to visit store with correct name
                    let message = "Reminder to vist \(name)"
                    guard let calendar = self.store.defaultCalendarForNewReminders() else { return }
                    let newReminder = EKReminder(eventStore: self.store)
                    newReminder.calendar = calendar
                    newReminder.title = message
                    // Set due date of reminder
                    newReminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self.dateTimePicker.date)
                    // Save reminder
                    try! self.store.save(newReminder, commit: true)
                    
                    
                }
            }
        }
        
    }
    
    // Return back to previous page when done pressed
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


}
