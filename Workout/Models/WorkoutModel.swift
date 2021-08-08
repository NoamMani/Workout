class WorkoutModel : Decodable {
    let totalTime : Int
    let exercises : [ExerciseModel]
    let setupSequence : String
    let reSetupSequence : [ReSetupSequenceModel]
}
