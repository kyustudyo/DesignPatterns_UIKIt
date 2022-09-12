# 소프트웨어의 개발 방법, software development pattern - MVC to MVVM

## MVC
MVC에서 Model 과 View를 분리하여 관리하면 수정도 쉽습니다. (앱의 미래의 확장 가능성 증진!)
"The Model" is where your data resides. Things like persistence, model objects, parsers, managers, and networking code live there.
"the controller entity" won’t know the concrete view it’s dealing with. Instead, it will communicate with an abstraction via a protocol. A classic example is the way a UITableView communicates with its data source via the UITableViewDataSource protocol.
"View"는 business logic 을 가져서는 안된다. UI와 관련되지 않은 모든것을 제외시킨다. Model을 건드리지 않는다.

- This way, everything is self-contained and your network layer doesn’t have to know the details of all your model objects in order to parse them. Business and parsing logic is all self-contained within the models.

## MVC -> MVVM
MVC -> MVVM: Business logic을 포함하는 ViewModel을 만들어, MVC와는 다르게 ViewController를 거의 data와 view를 '나타내는' 역할만 한다.
View 에서의 변화가 필요할 때나 Model에서의 변화가 필요할때 ViewModel을 통해 변한다.


###Reference: 
- https://www.raywenderlich.com/1000705-model-view-controller-mvc-in-ios-a-modern-approach
- https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html
