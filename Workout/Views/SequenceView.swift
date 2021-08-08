import SwiftUI

struct SequenceView: View {
    var chars : [String]
    var numberOfButtonsInRow = 3
    var charsOrderedByRows :  [Int : [String]]?
    var viewModel : SequenceViewModel
    
    init(viewModel : SequenceViewModel) {
        self.viewModel = viewModel
        chars = viewModel.sequenceModel.chars
        charsOrderedByRows = OrderCharsInRows()
    }
    
    var body: some View {
        return VStack(alignment: .center, spacing: 29){
            ForEach(charsOrderedByRows!.keys.sorted(by: <), id:\.self){row in
                HStack(alignment: .center, spacing: 10, content: {
                    ForEach(charsOrderedByRows![row]!, id:\.self){char in
                        CircleButton(action: {
                            viewModel.OnCharTapped(char: char)
                            if(viewModel.isSequenceCompleted){
                            }
                        }, label: char)
                    }
                })
            }
        }
    }
    
    
    
    func OrderCharsInRows() -> [Int : [String]]{
        var rows = [Int : [String]]()
        let numberOfRows = GetNumberOfRows()
        
        for row in 0...numberOfRows - 1 {
            rows[row] = []
            
            for i in 0...numberOfButtonsInRow - 1 {
                let currentCharIndex = row * numberOfButtonsInRow + i
                if(currentCharIndex < chars.count){
                    rows[row]!.append(chars[currentCharIndex])
                }
                else{
                    break
                }
            }
        }
        
        return rows
    }
    
    func GetNumberOfRows() -> Int{
        var numberOfRows = chars.count/numberOfButtonsInRow
        if(chars.count % numberOfButtonsInRow > 0){
            numberOfRows += 1
        }
        
        return numberOfRows
    }
}

//struct SequenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        SequenceView()
//    }
//}
