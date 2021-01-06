import Domain

struct LocationEntity: DataEntity {
    let typename: String
    let id: String
    let phone: String
    let address: AddressEntity
    let name: String
    let coordinates: CoordinatesEntity

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id, phone, address, name, coordinates
    }
    
    func toDomain() throws -> Location {
        Location(typename: typename,
                 id: id,
                 phone: phone,
                 address: try? address.toDomain(),
                 name: name,
                 coordinates: try? coordinates.toDomain())
    }
}
