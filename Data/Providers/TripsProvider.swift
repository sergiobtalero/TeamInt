import PromiseKit
import Domain

public final class TripsProvider {
    public init() {}
}

// MARK: - TripsProviderContract
extension TripsProvider: TripsProviderContract {
    public func getTripsList() -> Promise<[Trip]> {
        return Promise<[Trip]> { seal in
            firstly {
                DemoAuthClient().token()
            }.then { token -> Promise<WelcomeEntity> in
                TripsService.list(token: token).execute(object: WelcomeEntity.self)
            }.done { welcomeEntity in
                if let welcomeModel = try? welcomeEntity.toDomain(),
                   let models = welcomeModel.data?.driver?.loads?.trips {
                    seal.fulfill(models)
                } else {
                    seal.reject(TripsProviderError.generic)
                }
            }.catch { _ in
                seal.reject(TripsProviderError.generic)
            }
        }
        
    }
}
