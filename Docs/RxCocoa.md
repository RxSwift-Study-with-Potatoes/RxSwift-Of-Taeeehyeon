# RxCocoa 맛보기

또 다른 라이브러리인 RxCocoa에 대해서 알아봅시다.

- **기간 :** 2021.05.06(목) ~ 2021.05.11(화)  
- **작성자 :** 김태현

<br>

```
이번에는 RxCocoa에 대해서 알아봅시다^^
RxCocoa를 생각해보면 UI에 Rx를 적용하기 위한 라이브러리가 아닐까 싶습니다.

사실 위에서 이야기한 내용은 정확한 정의가 되지는 못합니다.
그러나 처음부터 정확한 이론이나 정의에 집중하다가는 공부할 맛이 나지 않을 것 같아서..
우선은 사용하고 봅시다!!!😏

어차피 내가 사용해봐야 정리가 되는거니깐 ~~

(소곤소곤)밑에서 이론을 살펴보긴 합니다🙃
```

<br>

## 들어가기전에
```
ㅇㅏ, 잠깐!! 절대 여기서 한 번에 다 이해안되는게 정상이니까 그냥 편하게 살펴봅시다~!~!🐶

본격적으로 들어가기전에 우리의 목표를 생각해봅시다. 
이 파트를 다 보고 난 뒤에는 어떤 모습을 갖춰야할지! 맞아요, 코드를 작성할수는 있어야 겠죠..? 우리 RxSwift 적용할거 잖아요! 
우리 RxCocoa 사용해서 UI 보여줄 거 잖아요!!!!!! (분노 😠) 👉 거의 분조장

솔직히 다 보고나서 이론은 기억못해도 코드 작성해볼 수 있도록 합시다 😁 

네 잠시 진정 좀 하고 천천히 하나씩 살펴보도록 하져~~ (맨날 서론이 긴 이상한 정리법..ㅎㅎ)
```

<br>
<br>

`RxCocoa의 개념` `control property` `bind` `trait` `drive`  등등에 대해서 알아보겠습니다..!

## RxCocoa란?

RxCocoa를 정리해서 말하면, 

- 애플 환경의 애플리케이션을 제작하기 위한 도구들을 모아놓은 Cocoa Framework를 Rx와 합친 기능을 제공하는 라이브러리
- UI Control과 다른 SDK 클래스를 Wrapping한 커스텀 Extension set 
(아니 왜 영어랑 한글이랑 섞어쓰는거지..;;)

이렇다고 합니다.

➕) 터치와 관련된 디바이스의 애플리케이션을 개발할 때 우리는 코코아 터치 프레임워크를 사용하는데요. 보통 iOS 개발할때는 코코아 터치 프레임워크를 사용합니다. 우리가 책보다 자주 만나는 UIKit이랑 Foundation 프레임워크가 이 안에 포함되어 있죠.

그러니까 Rx기능을 코코아 프레임워크에 합친것을 RxCocoa라고 하는 거고, UI Controls 관련해서 기능을 좀 더 확장했다고 생각하면 될까요..?

위에서 무슨 익스텐션 세트다, 코코아 프레임워크를 합친거다... 굉장히 추상적으로 설명이 되었는데, RxCocoa가 뭐냐고 제게 물어본다면,, 밑의 개념 정의가 가장 와닿을 것 같아서 다음과 같이 말할 거 같아요!

> RxSwift는 일반적인 Rx API라서, Cocoa나 특정 UIKit 클래스에 대한 아무런 정보가 없다. RxCocoa는 RxSwift의 동반 라이브러리로써, **UIKit과 Cocoa 프레임워크 기반 개발을 지원하는 모든 클래스를 보유**하는 친구이다.

**[인용 출처]**: [https://jinshine.github.io/2019/01/01/RxSwift/1.RxSwift란/](https://jinshine.github.io/2019/01/01/RxSwift/1.RxSwift%EB%9E%80/)

**⭐️ 한 줄 정리**

<u>UIKit 관련해서 개발할때도 Rx기능을 이용하고 싶어? 그럼 RxCocoa 라이브러리 사용하는거야 ~ 👌 ⁇</u>

---

## RxCocoa 좀 더 알아보기

(**subscribe), bind, drive를 이 3가지를 기억해봅시다.**

`binder` `driver` 에 대해서 이해했다면 사실상 오늘 목적은 거의 이룬거나 다름없음!!

## Subscribe

구독하는 대상(옵저버블)의 변함에 따라서 방출하는 Next 값과 Error 값, Complete 값 받아와서 처리할 수 있도록 도와주는 개념이었죠!

RxSwift에서는 구독자를 추가할 때 subscribe 메소드를 이용했는데, RxCocoa는 더 쉬운 방법을 제공합니다.

밑에서 살펴볼 바인딩(Binding)개념인데 subscribe 메서드 대신에 bind 메서드를 사용해서 구현해볼거에요.

## Binding

`하나의 연결 작업이라고 생각하면 좋을 듯 하네요~`

`데이터를 UI에 표시하기 위한 방-법` 

바인딩에는 데이터 생산자와 데이터 소비자가 있는데요! 간단하게 데이터 주는 사람이랑 데이터 받는 사람이라고 생각하면 되겠죠?? 👀

이 때 데이터의 흐름은 Uni-directional 입니다. 생산자 쪽에서 소비자 쪽으로 한쪽으로만 데이터가 전달됩니다.

👉 간단하게 정리해보죠!

- 데이터 생산자 : 옵저버블 (Observable) + 옵저버블타입 (Observable Type)을 채용한 모든 형식
- 데이터 소비자 : UIComponent (Label과 ImageView와 같은)

### Binder (Subscribe 확장판)

**바인더는 UI 바인딩에 사용되는 특별한 옵저버**입니다. 데이터 소비자의 역할을 하게 되는데요. 옵저버이기 때문에 옵저버블이 바인더에게 데이터 전달은 가능한데, 바인더는 옵저버블이 아니라서 구독자를 추가하지는 못해요!!

여기서 잠깐‼️ 중요한 키 포인트

- **Binder는 Error 이벤트를 받지 않습니다.**
    - 옵저버블은 Next, Completed, Error 이벤트를 방출하는데 Error를 받지 않는다는거죠! 조금만 생각해보면 그 이유를 알 수 있는데요?!
    - 자, 일단 Error이벤트가 발생되면 옵저버블이 어떻게 되나요??
    - 옵저버블 시퀀스가 종료가 되어버리죠..!!
    - UI의 경우 바뀐 결과나 값에 따라서 계속해서 업데이트가 되어야 하는데 종료가 되어버리면 더 이상 Next 이벤트를 받지 못해서 업데이트가 불가능하죠??

    **→ 그래서 Error 이벤트는 No No!!**

    바인딩이 성공하면 UI가 업데이트 됩니다~~ 대박 🙈

- **UI** 관련 작업은 **Main Thread** 에서 처리를 하게 되죠?

    ~~(혹시나,,, 모르면,,, 진짜로 안 돼ㅐㅐ)~~ 아니 모를 수도 있죠🙂 어쨌든 그렇습니다. UI 관련해서 업데이트하는 작업은 메인 스레드에서 처리가 진행됩니다.

    **→ Binder는 Binding이 메인 스레드에서 진행되는 것을 보장해줍니다.**

    cf) Subscribe 사용했을때와 비교해보기

    ```swift
    let bag = DisposeBag()

    // 문제가 되고 있는 코드
    // UI 관련 코드는 메인 스레드에서 실행되어야 한다고!!
    textField.rx.text 
    	.subscribe(onNext: { [weak self] str in 
    		self?.textLabel.text = str // #1 
    	}) 
    	.disposed(by: bag)

    // 해결책1. GCD 사용하기 (스레드 지정)
    textField.rx.text 
    	.subscribe(onNext: { [weak self] str in 
    		DispatchQueue.main.async { 
    			self?.textLabel.text = str 
    		} 
    	}) 
    	.disposed(by: bag)

    // 해결책2. rx의 observeOn 메서드 사용 (메인 스레드에서 동작하도록)
    textField.rx.text
    	.observeOn(MainScheduler.instance)
    	.subscribe(onNext: { [weak self] str in
    		self?.textLabel.text = str
    	})
    	.disposed(by: bad)
    ```

    근데 RxCocoa에서는 위의 2가지 방법을 이용하지 않아요.. 더 간단한 방법이 있습니다!!

    바로 bind 메서드를 사용해서 바인딩하는 방법..!

    ```swift
    // binder는 항상 메인 스레드에서 바인딩을 진행한다고 했었죠?
    // 위에서처럼 스레드 지정하는 고민을 할 필요가 없어요...
    // 그냥 bind씁시다!!
    textField.rx.text
    	.bind(to: textLabel.rx.text) // 파라미터로 ObserverType을 받고 있어요.
    	.disposed(by: bag)
    ```

**바인딩+바인더 개념 확인했으니깐 코드 작성하러 고고고 ~~~🤟**

- **Binding 구현 예제** ▶︎ 요 부분은 괜찮은거 생길때마다 추가할게요~

**솔직히 여기까지 왔을 때 기억나는거..**

- RxCocoa가 뭐였더라...?
- **Binding,, Binder,, bind 메서드,, 메인 스레드..? (Good👍)**
    - 이것만 기억나도 성공! 사용법만 익혀둡시다~

---

## Traits

`UI에 특화된 Observable` `Binder와는 반대..` `Driver만 기억해도 절반 성공`

Traits는 UI 처리에 특화된 Observable 입니다. 옵저버블이기 때문에, UI Binding에서 데이터 생산자 역할을 수행하겠죠? 기억 안나면 위에서 바인딩(Binding)개념 다시 보고 오기👀  한마디로 Binder와 반대되는 개념인데 RxCocoa에선 4가지 주요한 Traits가 있는데요~ 알아볼까요~~~~?!!!

Traits는 위에서 말했듯이 UI에 특화된 옵저버블이고, 모든 작업은 메인 스케쥴러(Main Scheduler)에서 실행이 됩니다. 한마디로 **메인 스레드(Main Thread)**에서 실행된다는 이야기에요!!

Wow~~?! 그러면 따로 스케쥴러를 지정할 필요가 없어요..!!!! Amazing?!

### ‼️ **중요**

여기서 잠깐, 잠깐만 짚고 넘어갈 이야기가 있어요.. 만약에 옵저버블 시퀀스가 에러 이벤트를 발생시킨다면? 에러 이벤트로 종료된다면 연결되어 있는 UI는 어떻게 될까요?

**맞아요.. 더 이상 UI 업데이트가 일어나지 않겠죠? 중간에 에러 한 번 발생해버리면 더 이상 업데이트가 안되니까 정말로 큰일이에요..**

그래서 우리는 Traits를 사용하게 됩니다.
Traits는 **에러 이벤트를 전달하지 않아서** 위 문제는 걱정하지 않아도 됩니다!!!

아, 그리고 원래 옵저버블을 구독하면 새로운 시퀀스가 시작이 되잖아요?? 근데 Traits는 옵저버블임에도 불구하고 새로운 시퀀스가 시작되지 않아요..!

### Traits 잠깐 정리

- UI에 특화된 옵저버블
- 메인 스레드에서 실행
- 에러 이벤트 전달 ❌
- 새로운 시퀀스 시작 ❌

솔직히 위에서 좋은 점만 이야기했기도 하고,, 사용하지 않을 이유가 딱히 없어요..!

그래서 적극적으로 활용하는 것을 추천한다고 합니다! (근데 필수는 아닙니다!)

아 점점 뭔가 너무 내용이 늘어나고 있는데 ~~(내 수면시간은 줄어드는중..ㅎㅎ)~~

Traits 4가지만 정리하고 개념적인 부분을 마무리하도록 합시다..

`control property` `control event` `driver` `signal`

### Traits 종류

1. **Control Property**

    컨트롤에 data를 바인딩하기 위해서 사용합니다.

    ![controlProperty](https://user-images.githubusercontent.com/61109660/117992264-c0ae5f80-b379-11eb-9011-0ba9f8fe85a8.png)

    - RxCocoa는 Extension으로 Cocoa의 View를 확장하고, 동일한 이름을 가진 속성을 추가합니다.
    - 이런 속성들 대부분 Control Property 형식으로 선언되어 있어요..
    - ControlPropertyType 프로토콜은 ObservableType과 ObserverType 프로토콜을 상속하고 있습니다.
    - ControlProperty는 특별한 옵저버블이면서 동시에 특별한 옵저버입니다.

        → 여기서 Subject가 떠오르는 건... 나만...그런건가

    - UI Binding에 사용되는데요.. 그래서 에러 이벤트를 전달 받지도 않고, 전달 하지도 않습니다.

2. **Control Event**

    컨트롤의 이벤트를 수신하기 위해 사용됩니다.

    ![controlEvent](https://user-images.githubusercontent.com/61109660/117992305-cad05e00-b379-11eb-8692-b48e252574ca.png)

    - UI Control을 상속한 Control들은 다양한 이벤트를 전달합니다.
    - ControlProperty와 달리 Observable의 역할은 수행하지만 Observer의 역할은 수행하지 못합니다.
    - 에러 이벤트 전달하지 않구요, Completed 이벤트는 Control이 해제되기 직전에 전달합니다!
    - 메인 스케쥴러에서 이벤트 전달합니다.
3. **⭐️ ⭐️ ⭐️  Driver**

    RxCocoa가 제공하는 Traits 중에서 가장 핵심적인 것이라고 봐도 과언이 아닙니다.

    Driver는 데이터를 UI에 바인딩하는 직관적이고 효율적인 방법을 제공합니다!

    **몇 가지 특징**을 가지는데,

    - 에러 이벤트를 전달하지 않아요 → 오류로 인해서 UI 처리가 중단되지 않겠죠?
    - 항상 메인 스케쥴러에서 작업을 수행해요 → 이벤트는 항상 메인 스케쥴러에서 전달되고, 이어지는 작업도 메인 스케쥴러에서 처리합니다.

    **예시 코드**

    ```swift
    viewModel.output.isLoading 
    	.asDriver() 
    	.drive(onNext: { [weak self] in 
    		self?.indicatorView.isHidden = !$0 
    	}) 
    	.disposed(by: disposeBag)

    viewModel.output.isLoading 
    	.observeOn(MainScheduler.instance) 
    	.subscribe(onNext: { [weak self] in 
    		self?.indicatorView.isHidden = !$0 
    	}) 
    .disposed(by: disposeBag)
    ```

    drive를 사용하려면 asDriver() 메서드를 통해서 옵저버블을 Driver 타입으로 만들어주어야 합니다!

4. **Signal (얘는 그냥 특징만 보고 넘어갑시다! 혹시 필요하면 다시 찾아보면 좋을 듯해요)**

    Driver와 거의 동일한데, 한 가지 다른 점은 자원을 공유하지 않는다는거에요!

    ⇒ share(replay:1) 사용하지 않아요..! ⇒ 새로운 구독자에게 마지막 요소를 보내주지 않아요!

---

### 👀 팁..?

[출처]:  [https://nsios.tistory.com/66](https://nsios.tistory.com/66)

- drive는 UI에 관련된 코드를 작성할 때 쓴다고 합니다.
    - relay와 drive를 통해서 안전하게 사용하구요.
- 값을 사용하기 위해 저장할때는 bind나 subscribe를 subject와 사용하는 편..ㅇ

아이고,, 요 내용 바탕으로 다시 한 번 정리해야겠다... 아직 뜬구름 잡는 느낌 ☁️

<br>

## 📚 참고자료
[[RxCocoa] 1. 맛보기](https://ios-development.tistory.com/137?category=909631)

[RxSwift 12) RxCocoa - 2/2](https://iospanda.tistory.com/entry/RxSwift-11-RxCocoa-22?category=751847)

[[RxSwift Book] Chapter 12: Beginning RxCocoa](https://jusung.github.io/RxSwift-Section12/)

[[RxSwift] bind, subscribe, drive](https://nsios.tistory.com/66)
