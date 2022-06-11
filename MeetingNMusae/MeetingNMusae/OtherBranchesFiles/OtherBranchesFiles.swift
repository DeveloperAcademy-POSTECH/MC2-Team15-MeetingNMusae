// 타 브랜치 필요 파일 (임시본) 모음 - 프로젝트 합칠 때 삭제 예정
import SwiftUI

// ref: 이하 코지의 UIScreen+Extensions 파일 내용.
struct Line: Shape { func path(in rect: CGRect) -> Path {
         var path = Path()
         path.move(to: CGPoint(x: 0, y: 0))
         path.addLine(to: CGPoint(x: rect.width, y: 0))
         return path
     }
 }
extension UIScreen {
     static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
     static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
     static let screenSize: CGSize = UIScreen.main.bounds.size
 }

// ref: 이하 닉 CharacterBox 내용.
// 에서 조금 수정
struct CharacterBox: View {
//     let width: CGFloat?
//     let height: CGFloat

     var body: some View {
         RoundedRectangle(cornerRadius: 12)
             .foregroundColor(.white)
//             .frame(width: width, height: height)
             .shadow(color: .black, radius: 0,  x: 8, y: 8)
             .overlay(
                 RoundedRectangle(cornerRadius: 12)
                     .stroke(Color.black, lineWidth: 3)
             )
     }
 }
