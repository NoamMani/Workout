import SwiftUI

struct SetupView: View {
    
    @ObservedObject var viewModel : SetupViewModel
    
    init(){
        viewModel = SetupViewModel()
    }
    
    
    var body: some View {
        
        ActivityView(viewModel: ActivityViewModel(workoutModel: viewModel.workoutModel))
//        
//        ZStack(alignment: .center){
//            NavigationView{
//                NavigationLink(
//                    destination: ActivityView(viewModel: ActivityViewModel(workoutModel: viewModel.workoutModel)),
//                    isActive: $viewModel.isSequenceCompleted,
//                    label: { Text("")
//                    })
//            }
//            
//            SequenceView(viewModel: viewModel.sequenceViewModel!)
//        }
    }
}



struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
