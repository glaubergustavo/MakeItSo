//
//  RemindersListViewModel.swift
//  MakeItSo
//
//  Created by madeinweb on 22/07/23.
//

import Foundation
import Combine
import Factory

class RemindersListViewModel: ObservableObject {
    @Published var reminders = [Reminder]()
    
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
      @Injected(\.remindersRepository)
      private var remindersRepository: RemindersRepository
    
    init() {
        remindersRepository
            .$reminders
            .assign(to: &$reminders)
    }
    
    func addReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.addReminder(reminder)
            errorMessage = nil
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func updateReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.updateReminder(reminder)
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteReminder(_ reminder: Reminder) {
        remindersRepository.removeReminder(reminder)
      }
    
    func setCompleted(_ reminder: Reminder, isCompleted: Bool) {
        var editedReminder = reminder
        editedReminder.isCompleted = isCompleted
        updateReminder(editedReminder)
    }
    
    func toggleCompleted(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id} ) {
            reminders[index].isCompleted.toggle()
        }
    }
}
