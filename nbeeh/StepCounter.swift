
import Foundation
import CoreMotion
import Combine

final class StepCounter: ObservableObject {

    @Published var steps: Int = 0
    @Published var isAvailable = CMPedometer.isStepCountingAvailable()
    @Published var errorMessage: String?

    private let pedometer = CMPedometer()

    func start() {
        guard CMPedometer.isStepCountingAvailable() else {
            isAvailable = false
            errorMessage = "عدّ الخطوات غير متاح على هذا الجهاز."
            return
        }

        pedometer.stopUpdates()
        steps = 0
        errorMessage = nil

        let startDate = Date()

        pedometer.startUpdates(from: startDate) { [weak self] data, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else { return }
                self?.steps = data.numberOfSteps.intValue
            }
        }
    }

    func stop() {
        pedometer.stopUpdates()
    }
}
