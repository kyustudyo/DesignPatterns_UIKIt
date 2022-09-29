# MVC, MVVM, Repository 패턴 파일 ✏️

0. SnapKit
1. Combine, Rx 
2. DI

MVC에서 KVO, NotificationCenter 같은 Observer Pattern을 사용했습니다. Delegate Pattern 또는 클로저를 이용한 completionHandler로 Model의 변화를 전달할 예정입니다.
todo: https://github.com/BestKora/Combine-MVVM-UIKit
# 
# 소프트웨어의 개발 방법, software development pattern - MVC to MVVM
## MVC
MVC에서 Model 과 View를 분리하여 관리하면 앱의 큰 수정이 있을때 용이합니다. (앱의 미래의 확장 가능성 증진!)
### Model, View, Controller
1. "The Model" is where your data resides. Things like persistence, model objects, parsers, managers, and networking code live there.
2. "the controller entity" won’t know the concrete view it’s dealing with. Instead, it will communicate with an abstraction via a protocol. A classic example is the way a UITableView communicates with its data source via the UITableViewDataSource protocol. You likely won’t do much testing in the controller layer as, for the most part, it’s meant to kick things off, trigger data loads, handle UI interactions, mediate between UI and model, etc.
3. "View"는 business logic 을 가져서는 안된다. UI와 관련되지 않은 모든것을 제외시킨다. View에서는 Model을 건드리지 않는다. 또한 Reusable하도록 작성..!

4. 기타사항
- This way, everything is self-contained and your network layer doesn’t have to know the details of all your model objects in order to parse them. Business and parsing logic is all self-contained within the models.
- There is no heavy reliance on completion blocks, delegation (outside of what the table view needs) or mixing up business logic in views or controllers. You also don’t have the dreaded “MVC: massive view controllers.” This occurs when too much of your business logic lives inside of the controller. 너무 많은 business logic 이 viewcontroller에 없도록 하자.
- 경계할것: The controller is doing network requests, parsing or persistence. Appdelegate에서 하더라.

## MVC -> MVVM
MVC -> MVVM: Business logic을 포함하는 ViewModel을 만들어, MVC와는 다르게 ViewController를 거의 data와 view를 '나타내는' 역할만 한다.
View 에서의 변화가 필요할 때나 Model에서의 변화가 필요할때 ViewModel을 통해 변한다.

### Reference: 
- https://www.raywenderlich.com/1000705-model-view-controller-mvc-in-ios-a-modern-approach
- https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html
- https://velog.io/@ictechgy/MVC-%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4#%08%EB%82%98%EC%98%AC-%EC%88%98-%EC%9E%88%EB%8A%94-%EC%A7%88%EB%AC%B8%EB%93%A4
- https://velog.io/@aurora_97/Combine-UIKit-MVVM-Combine-예제
