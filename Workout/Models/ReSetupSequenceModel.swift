class ReSetupSequenceModel : Decodable{
    let type: ReSetupType
    let code: String
    
    enum CodingKeys: String, CodingKey {
           case type, code
       }

    required init(from decoder: Decoder) throws {
        do{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codeString = String(try container.decode(Int.self, forKey: .code))
            self.code = codeString
            self.type = try container.decode(ReSetupType.self, forKey: .type)
        }
        catch{
            fatalError("Couldn't decode ReSetupSequenceModel :\n\(error)")
        }
    }
}
