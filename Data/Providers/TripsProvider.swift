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
    
    public func getTripsListMocked() -> [Trip] {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Trips", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let welcomeEntity = try? JSONDecoder().decode(WelcomeEntity.self, from: data),
              let welcomeModel = try? welcomeEntity.toDomain() else {
            fatalError("Could not load file")
        }
        return welcomeModel.data?.driver?.loads?.trips ?? []
    }
}
