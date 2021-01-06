import Foundation
import Domain

struct CoordinatesEntity: DataEntity {
    let typename: String
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case latitude, longitude
    }
    
    func toDomain() throws -> TripCoordinates {
        TripCoordinates(typename: typename,
                        latitude: latitude,
                        longitude: longitude)
    }
}
