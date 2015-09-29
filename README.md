## FATodos
Many app about TODO, but it is my own.

旨在打造一个自己日常依赖的工具（首先得自己用得着嘛），然后改进。

## 模式 VIPER View.Interactor.Presenter.Entity.Routing

* View：ViewController

    ==> 持有Presenter

* Presenter：数据加工，更新数据到View（通知机制：ReactiveCocoa）

    ==> 持有Interactor

* Frame：持有View、ViewController（用于present、dismiss）
* Interactor：DataSource, Entity, 连接Presenter
* Entity：数据模型、持久化
* Routing：小维度是frame，大流程AppDependence


## 项目目录结构
* Documentation
* Image
* Category
* Entity
* Framework
    ==> SAMURAI，当成工具库，未使用其核心思想

* Interactor
* Presenter
* Router
* Vendor
* View


## 功能模块
* 1. FourQuadrant (事务)四个象限
* 2. Pushup 俯卧撑等等
* 3. Diagram 统计图表
* 4. Memo 便签
* 5. Note 日记
* 6. 

## 特点
* 1. 语音输入（推荐：懒人日记）（科大讯飞的语音sdk）

