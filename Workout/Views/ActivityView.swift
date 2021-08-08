import SwiftUI

struct ActivityView: View {
    @ObservedObject var viewModel : ActivityViewModel
    @State var isPauseButtonTapped : Bool = false
    @State var isResumeButtonTapped : Bool = false
    @State var isFinishButtonTapped : Bool = false
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            //Workout timer
            VStack(alignment: .leading){
                HStack(alignment: .bottom){
                    Spacer()
                    Text(SecondsToStringMinAndSec(secondsInput: self.viewModel.timePassed))
                        .foregroundColor(Color.white)
                }
                Spacer()
            }     .padding(EdgeInsets(top: 57, leading: 0, bottom: 0, trailing: 39))
            
            VStack(alignment: .center, spacing: 122)
            {
                ExerciseDetails()
                PauseButton()
            }.padding([.trailing, .leading], 30)
        }
    }
    
    func ExerciseDetails() -> some View{
        return VStack(alignment: .center, spacing: 55){
            //Exercise name
            Text(self.viewModel.currentExerciseName)
                .foregroundColor(.white)
                .font(.system(size: 48))
                .frame(height: 109, alignment: .center)
            
            //Exercise remaining time
            Text(SecondsToStringMinAndSec(secondsInput: self.viewModel.currentExerciseRemainingTime))
                .foregroundColor(.white)
                .font(.system(size: 64))
        }
    }
    
    func PauseButton() -> some View{
        return Button(action: OnPause, label: {
            Text("PAUSE")
                .foregroundColor(Color.black)
                .fontWeight(.medium)
                .font(.system(size: 24))
        })
        .frame(width: 234, height: 59, alignment: .center)
        .background(Color.white)
        .cornerRadius(19)
        .alert(isPresented: $isPauseButtonTapped, content: PausedTappedAlert)
    }
    
    func SecondsToStringMinAndSec(secondsInput : Int) -> String{
        let minutes = secondsInput / 60
        let seconds = secondsInput % 60
        
        return String(format:"%02d:%02d", minutes, seconds)
    }
    
    func OnPause(){
        self.viewModel.PauseWorkout()
        self.isPauseButtonTapped = true
    }
    
    func PausedTappedAlert() -> Alert{
        return Alert(title: Text("The workout is paused"),
                     message: Text("Please choose an option"),
                     primaryButton: .default(Text("Resume"),
                                             action: OnResume),
                     secondaryButton: .default(Text("Finish"),
                                               action: OnFinish)
        )
    }
    
    func OnResume(){
        self.viewModel.ResumeWorkout()
    }
    
    func OnFinish(){
        self.viewModel.FinishWorkout()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityView(viewModel: ActivityViewModel())
//    }
//}
