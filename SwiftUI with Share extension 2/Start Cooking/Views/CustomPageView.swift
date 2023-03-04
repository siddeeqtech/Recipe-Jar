import SwiftUI

struct CustomPageView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content

    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
                    .background(.white)
            }
            //.frame(width: geometry.size.width, alignment: .topLeading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)

            .offset(x: self.translation)

            .animation(.default, value: currentIndex)
                    .gesture(
                        DragGesture()//when drag gesture ends decides if user swipped left or right
                            .onEnded({ value in
            
                                //if user moved thier finger 10 pixels to left or to right count it as a swipe
                                if value.translation.width > 10 { //if the finger move to right
            
                                    if self.currentIndex > 0 {//once the user reached the end of hstack they shouldnt be able to scroll out of hstack
                                        self.currentIndex -= 1
                                    }
                                }
                                else if value.translation.width < -10 {
                                    if self.currentIndex < pageCount-1 {//change it to number of steps in a recipe
                                        self.currentIndex += 1
                                    }
                                }
                            })
        )}
    }
}
