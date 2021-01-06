import Domain

struct AddressEntity: DataEntity {
    let typename: String
    let street: String
    let street2: String?
    let city: String
    let postalCode: String
    let state: String
    let country: String

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case street, street2, city, postalCode, state, country
    }
    
    func toDomain() throws -> Address {
        Address(typename: typename,
                street: street,
                street2: street2,
                city: city,
                postalCode: postalCode,
                state: state,
                country: country)
    }
}
