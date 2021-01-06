import Domain

struct TruckingOrderEntity: DataEntity {
    let typename: String
    let id: String
    let tripDistanceMiles: Double
    let orderType: String
    let locationFrom: LocationEntity
    let locationTo: LocationEntity

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id, tripDistanceMiles, orderType, locationFrom, locationTo
    }
    
    func toDomain() throws -> TruckingOrder {
        TruckingOrder(typename: typename,
                      id: id,
                      tripDistanceMiles: tripDistanceMiles,
                      orderType: orderType,
                      locationFrom: try? locationFrom.toDomain(),
                      locationTo: try? locationTo.toDomain())
    }
}
