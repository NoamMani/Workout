import Foundation

class ActivityViewModel: ObservableObject {
    var workoutModel:WorkoutModel
    var exercises : [WorkoutPartBaseModel]
    var timer : Timer?
    @Published var timePassed : Int = 0
    @Published var currentExerciseRemainingTime : Int = 0
    @Published var currentExerciseName : String = ""
    var currentExerciseIndex : Int = 0
    
    init(workoutModel : WorkoutModel) {
        self.workoutModel = workoutModel
        exercises = [WorkoutPartBaseModel]()
        exercises = GetFullWorkoutFlow(workoutModel: workoutModel)
        StartWorkout()
    }
    
    func GetFullWorkoutFlow(workoutModel : WorkoutModel) -> [WorkoutPartBaseModel]
    {
        var fullWorkoutflow = [WorkoutPartBaseModel]()
        var currentSecond = 1
        
        for exercise in workoutModel.exercises
        {
            if(currentSecond < exercise.startTime)
            {
                let rest = RestModel(startTime: currentSecond, totalTime: exercise.startTime - 1)
                fullWorkoutflow.append(rest)
            }
            
            fullWorkoutflow.append(exercise)
            currentSecond = exercise.totalTime + 1
        }
        
        if(fullWorkoutflow.count > 0 && fullWorkoutflow.last!.totalTime < workoutModel.totalTime)
        {
            let rest = RestModel(startTime: currentSecond, totalTime: workoutModel.totalTime)
            fullWorkoutflow.append(rest)
        }
        
        return fullWorkoutflow
    }
    
    func StartWorkout(){
        let currentExrcise = exercises[currentExerciseIndex]
        currentExerciseName = currentExrcise.name
        currentExerciseRemainingTime = currentExrcise.getDuration()
        
        StartWorkoutTimer()
    }
    
    func StartWorkoutTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            self.OnTimeElapsed()
        }
    }
    
    func OnTimeElapsed(){
        if(IsWorkoutCompleted()){
            StopWorkout()
        }
        else{
            timePassed += 1
            if(IsCurrentExerciseOver()){
                MoveNextExercise()
            }
            else{
                currentExerciseRemainingTime -= 1
            }
        }
    }
    
    func IsWorkoutCompleted() -> Bool{
        return self.timePassed == self.workoutModel.totalTime
    }
    
    func StopWorkout() {
        self.timer?.invalidate()
    }
    
    func IsCurrentExerciseOver() -> Bool{
        return self.currentExerciseRemainingTime == 0
    }
    
    func MoveNextExercise(){
        self.currentExerciseIndex += 1
        
        self.currentExerciseName = self.exercises[self.currentExerciseIndex].name
        self.currentExerciseRemainingTime = self.exercises[self.currentExerciseIndex].getDuration()
    }
    
    func PauseWorkout(){
        timer?.invalidate()
    }
    
    func ResumeWorkout(){
        //To avoid a delay between resume to first timer fire
        OnTimeElapsed()
        
        StartWorkoutTimer()
    }
    
    func FinishWorkout(){
        
    }
}
