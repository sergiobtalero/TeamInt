import Domain

struct DataClassEntity: DataEntity {
    let driver: DriverEntity
    
    func toDomain() throws -> DataClass {
        DataClass(driver: try? driver.toDomain())
    }
}
