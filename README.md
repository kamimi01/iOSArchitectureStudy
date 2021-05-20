# 「iOSアプリ設計パターン入門」から学ぶ、設計の基礎

## Table of Contents
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<details>
<summary>Details</summary>

- [2種類のアーキテクチャ](#2%E7%A8%AE%E9%A1%9E%E3%81%AE%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3)
- [GUIアーキテクチャ](#gui%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3)
  - [Model-View-Controller（MVC）モデル](#model-view-controllermvc%E3%83%A2%E3%83%87%E3%83%AB)
    - [UML](#uml)
    - [特徴](#%E7%89%B9%E5%BE%B4)
    - [実装](#%E5%AE%9F%E8%A3%85)
    - [課題](#%E8%AA%B2%E9%A1%8C)
  - [Presentation Modelパターン（Application Modelパターン）](#presentation-model%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3application-model%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3)
    - [UML](#uml-1)
    - [特徴](#%E7%89%B9%E5%BE%B4-1)
    - [課題](#%E8%AA%B2%E9%A1%8C-1)
  - [Model-View-ViewModel（MVVM）](#model-view-viewmodelmvvm)
    - [UML](#uml-2)
    - [特徴](#%E7%89%B9%E5%BE%B4-2)
    - [課題（デメリット）](#%E8%AA%B2%E9%A1%8C%E3%83%87%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
    - [参考](#%E5%8F%82%E8%80%83)
  - [Model-View-Presenter（MVP）](#model-view-presentermvp)
    - [MVP（Taligent）](#mvptaligent)
    - [MVP（Supervising Controller）](#mvpsupervising-controller)
    - [MVP（Passive View）](#mvppassive-view)
  - [Flux](#flux)
    - [UML](#uml-3)
    - [特徴](#%E7%89%B9%E5%BE%B4-3)
  - [Redux](#redux)
    - [特徴](#%E7%89%B9%E5%BE%B4-4)
- [システムアーキテクチャ](#%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3)
  - [レイヤードアーキテクチャ](#%E3%83%AC%E3%82%A4%E3%83%A4%E3%83%BC%E3%83%89%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3)
  - [Hexagonal Architecture（Ports And Adapters Architecture）](#hexagonal-architectureports-and-adapters-architecture)
    - [参考](#%E5%8F%82%E8%80%83-1)
  - [Onion Architecture](#onion-architecture)
    - [参考](#%E5%8F%82%E8%80%83-2)
  - [Clean Architecture](#clean-architecture)
- [モバイルアプリにおけるアーキテクチャ](#%E3%83%A2%E3%83%90%E3%82%A4%E3%83%AB%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3)
  - [CoordinatorパターンとMVVM-C](#coordinator%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%81%A8mvvm-c)
    - [参考](#%E5%8F%82%E8%80%83-3)
  - [RouterパターンとVIPER](#router%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%81%A8viper)

</details>
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 2種類のアーキテクチャ

- GUIアーキテクチャ
- システムアーキテクチャ

- Presentation Domain Separation（PDS）
  - ドメイン（Modelと呼ばれ、システム本来の関心領域）を、プレゼンテーション（Viewと呼ばれ、UIに関するロジック）から引き離す
  - PDSを実践する際の具体的なレイヤー構造をパターンとして示すのが、GUIアーキテクチャ

## GUIアーキテクチャ

### Model-View-Controller（MVC）モデル

#### UML

![](./MVC/MVCモデル.png)

#### 特徴

- ウィジェット単位でプレゼンテーションロジックとドメインを分離する
- Modelの変更にたいし、オブザーバー 同期が行われる

#### 実装

- Model
  - NotificationCenterを使用して、Modelの変更をViewとControllerに通知できるようにする
    - [【Swift】NotificationCenterの使い方](https://qiita.com/ryo-ta/items/2b142361996657463e5f)
    - [NotificationCenter.addObserverのドキュメントがわからない](https://qiita.com/eytyet/items/2690c570088a062b4afc)
    - [iOSアプリのしくみ・アプリ内通知](https://note.com/kaigian/n/n62db4f735068#T1LjS)
  - didSetを使い、変数の変更を通知する
    - [Swiftのプロパティ監視willset/didset](http://tc-kazuki.hatenablog.jp/entry/2017/11/17/134050)
- Controller
  - Modelに処理を依頼するため、Modelをプロパティとして保持する（だが、更新通知は受け取らない）
  - Viewで定義するUIコンポーネントのイベントを直接受け取るために、`@objc`修飾子をつける
    - イベントを受け取ったら、Modelに処理を依頼する
  - その他の知識
    - 必須イニシャライザ
      - サブクラスでの実装が必須となる
      - [Swiftとイニシャライザ](https://qiita.com/shtnkgm/items/8b7979fc84a3cc065238)
    - メタタイプ（Type）
      - `type(of:)`で型を取得でき、`String.Type`のようになる
      - [[Swift 3] 型名を取得する](https://dev.classmethod.jp/articles/swift-3-type-of/)
      - [Swift Type Metadata (ja)](https://kateinoigakukun.hatenablog.com/entry/2019/03/22/180030)
    - 循環参照を起こさせない`[unowned self]`
      - キャプチャ`[]`で囲うとその後その変数に何を代入しても代入前の値を見るようになる
      - [普段なにげなく書いている[unowned self]の意味を調べる](https://qiita.com/shimesaba/items/f433de0850bf09a1d50d)

#### 課題

- プレゼンテーションロジックの表現ができない
- プレゼンテーション状態を表現できない
- テストが難しい

### Presentation Modelパターン（Application Modelパターン）

#### UML

![](./PresentationModel/Presentation%20Modelパターン（Application%20Modelパターン）.png)

#### 特徴

- Presentation Modelに、プレゼンテーションロジックやプレゼンテーション状態の管理を担わせる
- MVCパターンの3つの課題を全て解決できる
  - ロジックがViewから切り離されていれば、Viewのインスタンスを用意しなくてもテスト可能
- AspectAdaptorなどの仕組みの導入
  - SwiftでいうKeyPathによるKVOのようなもので、Modelが更新された時の動作をプロパティの指定だけで簡単に描けるようにサポートしてくれている（よくわからん）
    - 参考：[The power of key paths in Swift](https://www.swiftbysundell.com/articles/the-power-of-key-paths-in-swift/)

#### 課題

- 特になし？

### Model-View-ViewModel（MVVM）

#### UML

![](./MVVM/Model-View-ViewModel（MVVM）.png)

#### 特徴

- 構造は、Application Modelとほぼ変わらないが、**Controllerのレイヤーが存在しない**
- ViewのテンプレートをXAML（XMLベースのDSL）で宣言する
- その宣言に従い、システムが実行時に自動的にViewとViewModelをバインドするため、コードを書かずともViewModelの状態がViewへ反映される
- Viewクラスは動的に

#### 課題（デメリット）

- 大きなアプリケーションのためのアーキテクチャであり、単純なアプリケーションに置いては実装コストが「オーバーキル」（過剰）である
- 大きなアプリケーションであったとしても、データバインディングがメモリ効率に影響を与える可能性がある

#### 参考

- SwiftUIは、MVVMに相当すると考えられる
  - 開発者から見て、アノテーションをつけることで自動的にViewModelの状態が自動的にViewへ反映される
  - [メモアプリ開発でSwiftUIによるMVVMを学んでみた](https://tech-blog.rakus.co.jp/entry/20210331/swift)
- [MVVMでiOSアプリをつくってみた](https://qiita.com/am10/items/b35355df807105600f51)

### Model-View-Presenter（MVP）

- 以下3つのMVPが存在する
  - MVP（Taligent）
  - MVP（Supervising Controller）
  - MVP（Passive View）

#### MVP（Taligent）

- MVCのそれぞれの責務をさらに細かく分割し、Controllerを一般化した存在として、Presenterを置いた
- Presenterは、アプリケーション全ての入力イベントを管理する

#### MVP（Supervising Controller）

![](./MVP/MVP_Supervising/Model-View-Presenter（Supervising）.png)

- Viewの特徴
  - MVCのViewとは異なり、ユーザー操作の受付をContollerではなく、Viewで行う
  - Viewが直接Modelの変更を監視する
    - オブザーバ同期
    - フロー同期
- Presenterの特徴
  - Application Modelに似ているが、よりViewに近いレイヤー
    - Application Modelは、Modelに属する
  - Viewの実体を直接知っている
    - 複数のViewのインスタンスを管理し、それらを階層的に取り扱う
- Modelの特徴
  - 純粋なドメインロジックの表現

#### MVP（Passive View）

![](./MVP/MVP_PassiveView/Model-View-Presenter（Passive%20View）.png)

- テストしやすい、TDDサイクルを回せるアーキテクチャ
- Passive View
  - オブザーバ同期をやめたView
  - Viewが完全に受動的な存在に
- Appleが提唱する「Cocoa MVC」はMVP（Passive View）のことと考えて良い

### Flux

#### UML

![](./FLUX/FLUX.png)

#### 特徴

- 単一方向のデータフロー

### Redux

#### 特徴

- Fluxを発展させ、関数型言語のElmの影響を大きく受けたアーキテクチャ

## システムアーキテクチャ

- ドメインの先でどのようにレイヤーを切り分けるべきか、システム全体をどのように接合すべきかを示す仕組みのこと

### レイヤードアーキテクチャ

![](./LayeredArchitecture/レイヤードアーキテクチャの最終形態.png)

- 関心によってレイヤーを分ける
- Domain層がData層に依存しないよう、Dependency Injection（依存オブジェクトの注入）を行った
  - それにより、Data層へのドメイン知識の漏洩は防がれる

### Hexagonal Architecture（Ports And Adapters Architecture）
![](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F30489%2F7e133df6-2b84-d6f6-e09e-75a1182eec0b.png?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&w=1400&fit=max&s=f7f3f072dc79719ac538b73b594b9ec1)

- iOSにおけるプライマリアダプターとセカンダリアダプター
![](https://miro.medium.com/max/1956/1*9B1EsZPbhElSEFDZU3IpXA.png)

- Presentation層でも、Domain層にあるべきドメイン知識が漏洩しがちだったが、それを防ぐ
  - DataやPresentation層を「外部との接続に関するレイヤー」として捉える
- ポートとアダプターの概念がある
  - ポート
    - 外部との接続
    - 目的の単位で抽象化される
  - アダプター
    - 差し込まれた外部モジュールの実装詳細を隠蔽し、ポートが期待するインターフェースへの変換する
    - プライマリアダプター
      - アプリケーションを駆動するためのもの
    - セカンダリアダプター
      - アプリケーションによって駆動されるためのもの

#### 参考

- [Hexagonal Architecture for iOS](https://betterprogramming.pub/hexagonal-architecture-for-ios-part-1-600441c186b7)

### Onion Architecture

![](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.amazonaws.com%2F0%2F30489%2F18f36be6-c6b7-d99c-c7cb-63f1ec443a28.png?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&w=1400&fit=max&s=4fa74e2a614f8e4e54366928492cf29a)

- 基本的な考えは、Hexagonal Architectureと変わりない
- 同じく、Data層を外側におき、Adapterパターンによってアプリケーションを疎結合に保つもの
- Hexagonal Architectureとの違い
  - アプリケーションの視覚表現として、六角形ではなく円を用いている
  - アプリケーション内部を複数の円で分割している
- 円の中心にあるのは、モデルの状態と振る舞いを表現するDomain Model
  - **Domain ServiceやApplication Serviceがあるが、必ずしもそのレイヤーに分かれている必要はない**
- 4つの特徴
  - アプリケーションは自立したオブジェクトモデルを取り囲むように作られる
  - 内側のレイヤーはインターフェースを定義し、外側のレイヤーはそれを実装する
  - 依存の方向は外側から内側
  - Application Coreはインフラストラクチャ（Data層）抜きでコンパイル・実行できる

#### 参考

- [[DDD]ドメイン駆動 + オニオンアーキテクチャ概略](https://qiita.com/little_hand_s/items/2040fba15d90b93fc124)

### Clean Architecture

![](https://qiita-image-store.s3.amazonaws.com/0/30489/ede07478-3be1-732a-82b3-c3558f4c9e49.png)

- 今まで提唱された様々なアーキテクチャを統合したもの

## モバイルアプリにおけるアーキテクチャ

- 画面遷移をどう設計するか

### CoordinatorパターンとMVVM-C

- アプリのルートに存在するApplicaion Coordinatorを頂点とした階層構造によって画面遷移を表現する
- 一般的には、画面遷移を行う場合は、View Controller内で次のView Controllerをインスタンス化し、Navigation ControllerへのpushやModalのpresentを行うが、それだと、View Controllerは次のView Controllerを指定いる必要がある。
  - 遷移先が複数存在する場合や、使いまわしたい場合に、遷移ロジックが肥大化するのを防ぐ

#### 参考

- [How to use the Coordinator pattern in iOS](https://www.youtube.com/watch?v=7HgbcTqxoN4)

### RouterパターンとVIPER

- 「View」「Iteractor」「Presenter」「Entity」「Routing」
- Clean Architecture +  MVP（Passive View） + Router
  - RouterはPresenterに画面遷移を指示する
- Routerの役割
  - 遷移先のView Controllerの生成
  - 遷移先のView Controllerが依存するコラボレーターの生成と代入
  - 画面遷移の実施方法の定義