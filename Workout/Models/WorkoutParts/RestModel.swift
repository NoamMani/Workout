class RestModel: WorkoutPartBaseModel {
    var name: String
    var startTime: Int
    var totalTime: Int
    
    init(startTime:Int, totalTime:Int) {
        self.name = "Rest"
        self.startTime = startTime
        self.totalTime = totalTime
    }
}
