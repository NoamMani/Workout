import Foundation

class SequenceViewModel : ObservableObject{
    let sequenceModel : SequenceModel
    var insertedSequence : String = ""
    var isSequenceCompleted : Bool = false
    var onSequenceCompleted : () -> Void
    
    init(sequenceModel : SequenceModel, onSequenceCompleted : @escaping () -> Void){
        self.onSequenceCompleted = onSequenceCompleted
        self.sequenceModel = sequenceModel
    }
    
    func OnCharTapped(char : String){
        if(insertedSequence.count == sequenceModel.sequence.count){
            insertedSequence = ""
        }
        
        insertedSequence.append(char.lowercased())
        
        if(insertedSequence == sequenceModel.sequence){
            onSequenceCompleted()
        }
    }
}
