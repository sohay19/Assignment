# Assignment

패스트레인 사전과제입니다.

[개발환경]
- Swift 5
- Xcode 12 (Project Document Format 버전을 의미하며 실제 Xcode는 14.2를 사용하였습니다.) 
- iOS Deployment Target 11

[간단한 프로젝트 설명]
- 메인화면(Main), 상세화면(Detail)으로 구성되어있습니다.
- 다양한 데이터 구조 Model들과 서버에서 데이터를 가져와 보유하는 DataViewModel, View가 필요한대로 데이터를 가공하여 ViewContoller에게 전달하는 Controller가 존재합니다.

[Main]
- TableView를 기본으로 만들어졌으며, Custom TableHeaderView 내부 CollectionView 이용해 '여신TV 인기영상'부분을 제작하였습니다.
- 하단의 '추천이벤트', '신규이벤트'는 섹션으로 나뉘어 제작되었으며 타이틀은 섹션헤더를 사용하였습니다.

[Detail]
- present로 뷰 컨트롤러를 띄울 때 콘텐츠 타입에 따라 데이터를 전달하며 상단에 close 버튼을 이용하여 나갈 수 있습니다.

[그 외]
- 로딩 뷰가 추가되어있습니다.
- 썸네일이 사라진 부분이 많아 임의의 썸네일을 설정해두었습니다.
