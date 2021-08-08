import Foundation

class SetupViewModel : ObservableObject {
    let workoutModel : WorkoutModel
    var sequenceModel : SequenceModel
    var sequenceViewModel : SequenceViewModel?
    @Published var isSequenceCompleted : Bool = false
    
    init(){
        workoutModel = DataService.instance.GetWorkout()
        sequenceModel = SequenceModel(sequence:workoutModel.setupSequence , chars: ["A","B","C","D","E","F"])
        sequenceViewModel = SequenceViewModel(sequenceModel: sequenceModel, onSequenceCompleted: onSequenceCompleted)
    }
    
    func onSequenceCompleted(){
        isSequenceCompleted = true
    }
}
