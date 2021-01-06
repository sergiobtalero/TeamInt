import Domain

struct DriverEntity: DataEntity {
    let typename: String
    let loads: LoadsEntity

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case loads
    }
    
    func toDomain() throws -> Driver {
        Driver(typename: typename,
               loads: try loads.toDomain())
    }
}
