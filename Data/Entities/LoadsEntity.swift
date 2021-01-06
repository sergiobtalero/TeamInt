import Domain

struct LoadsEntity: DataEntity {
    let typename: String
    let trips: [TripEntity]

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case trips
    }
    
    func toDomain() throws -> Loads {
        Loads(typename: typename,
              trips: try? trips.toDomain())
    }
}
