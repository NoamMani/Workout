 protocol WorkoutPartBaseModel {
    var name: String { get set }
    var startTime: Int { get set }
    var totalTime: Int { get set }
}
 
 extension WorkoutPartBaseModel{
    func getDuration() -> Int{
        return totalTime - startTime + 1
    }
 }
