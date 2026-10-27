//
//  Untitled.swift
//  nbeeh
//
//  Created by Jumanah on 16/05/1448 AH.
//
import Foundation
import Combine

struct DailyPerformance: Codable, Identifiable {

    var id: UUID = UUID()
    var date: Date

    var steps: Int

    var auditoryCorrect: Int
    var auditoryTotal: Int

    var visualCorrect: Int
    var visualTotal: Int

    var isCompleted: Bool

    var totalCorrect: Int {
        auditoryCorrect + visualCorrect
    }

    var totalAttempts: Int {
        auditoryTotal + visualTotal
    }

    var accuracy: Double? {
        guard totalAttempts > 0 else {
            return nil
        }

        return Double(totalCorrect)
            / Double(totalAttempts) * 100
    }
}

@MainActor
final class PerformanceStore: ObservableObject {

    static let shared = PerformanceStore()

    @Published private(set) var sessions: [DailyPerformance] = []

    private let storageKey = "nbeeh.dailyPerformance.v1"

    private init() {
        load()
    }

    func save(_ session: DailyPerformance) {

        let calendar = Calendar.current

        guard calendar.isDateInToday(session.date) else {
            return
        }

        // One completed challenge per calendar day
        guard !sessions.contains(where: {
            calendar.isDate($0.date, inSameDayAs: session.date)
                && $0.isCompleted
        }) else {
            return
        }

        sessions.removeAll {
            calendar.isDate($0.date, inSameDayAs: session.date)
        }

        sessions.append(session)
        persist()
    }

    func session(on date: Date) -> DailyPerformance? {
        sessions.first {
            Calendar.current.isDate(
                $0.date,
                inSameDayAs: date
            )
        }
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(sessions) else {
            return
        }

        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(
            forKey: storageKey
        ),
        let saved = try? JSONDecoder().decode(
            [DailyPerformance].self,
            from: data
        ) else {
            return
        }

        sessions = saved
    }
}
