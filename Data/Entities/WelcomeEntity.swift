import Domain

struct WelcomeEntity: DataEntity {    
    let data: DataClassEntity
    
    func toDomain() throws -> Welcome {
        Welcome(data: try? data.toDomain())
    }
}
