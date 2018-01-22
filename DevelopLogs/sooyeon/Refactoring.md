## feature/design/signup branch와 feature/refactoring/180112 branch의 차이점

#### Refactoring이란?
- 결과의 변경 없이 코드의 구조를 재조정함(내부 논리나 구조를 바꾸고 개선하는 유지보수 행위)
- 가독성을 높이고 유지보수를 편하게 함
- 버그를 없애거나 새로운 기능을 추가하는 행위가 아님
- ex) 필드 은닉, 메서드 추출, 타입 일반화, 메서드 이름 변경 등

#### LoginViewController
1. CustomMethods.swift 파일
  - feature/design/signup: 없음
  - feature/refactoring/180112: 있음

2. userConnected 함수
  - feature/design/signup: self.spinner.stopAnimating()
  - feature/refactoring/180112: spinner.stopAnimating()

3. viewDidLoad 함수
  - feature/design/signup:  
  if FBSDKAccessToken.current() == nil {  
    print("facebook not log in")  
  } else {  
    print("facebook log in")  
  }
  - feature/refactoring/180112: 없음

#### SignUpViewController
1. emailInfoSaved 함수
  - feature/design/signup: 없음
  - feature/refactoring/180112: 있음

2. doneButtonDidEn/Disabled 함수
  - feature/design/signup: 있음
  - feature/refactoring/180112: CustomMethods.swift 파일로 옮겨짐

3. viewDidLoad 함수
  - feature/design/signup: doneButtonDidDisabled()
  - feature/refactoring/180112: buttonDisabled(doneButton)

#### RegisterUserInfoViewController
1. leftPaddingAdded 함수
  - feature/design/signup: 있음
  - feature/refactoring/180112: 없음

2. doneButtonDidEn/Disabled 함수
  - feature/design/signup: 있음
  - feature/refactoring/180112: CustomMethods.swift 파일로 옮겨짐

3. viewDidLoad 함수
  - feature/design/signup: doneButtonDidDisabled()
  - feature/refactoring/180112: buttonDisabled(doneButton)
