// MARK: - Welcome
struct Welcome: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let driver: Driver
}

// MARK: - Driver
struct Driver: Codable {
    let typename: String
    let loads: Loads

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case loads
    }
}

// MARK: - Loads
struct Loads: Codable {
    let typename: String
    let trips: [Trip]

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case trips
    }
}

// MARK: - Trip
struct Trip: Codable {
    let typename, id, deliveryStatus, progress: String
    let deliveredAt, scheduledDeliveryOn: String
    let truckingOrder: TruckingOrder

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id, deliveryStatus, progress, deliveredAt, scheduledDeliveryOn, truckingOrder
    }
}

// MARK: - TruckingOrder
struct TruckingOrder: Codable {
    let typename, id: String
    let tripDistanceMiles: Double
    let orderType: String
    let locationFrom, locationTo: Location

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id, tripDistanceMiles, orderType, locationFrom, locationTo
    }
}

// MARK: - Location
struct Location: Codable {
    let typename, id, phone: String
    let address: Address
    let name: String
    let coordinates: Coordinates

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id, phone, address, name, coordinates
    }
}

// MARK: - Address
struct Address: Codable {
    let typename, street: String
    let street2: String?
    let city, postalCode, state, country: String

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case street, street2, city, postalCode, state, country
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let typename: String
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case latitude, longitude
    }
}
