# PuzzleKit

PuzzleKit 是一个轻量级、灵活的 iOS UI 组件框架，旨在帮助开发者快速构建可复用、模块化的界面组件。通过拼图式的组合方式，让复杂界面的构建变得简单高效。

## 主要特性

- 🏗️ 模块化组件系统，支持业务与展示分离
- 🎯 类型安全的事件总线机制
- 📐 灵活的布局系统，支持列表、网格等多种布局方式
- ♻️ 高度可复用的单元格模型

## 系统设计

PuzzleKit 采用组件化架构，主要包含以下几个核心层次：

### 1. 组件层

- **PuzzleBusinessComponent**：业务逻辑组件，负责数据处理和业务逻辑
- **PuzzleDisplayComponent**：展示组件，负责界面渲染和用户交互
  - **PuzzleListComponent**：列表展示组件
  - **PuzzleGridComponent**：网格展示组件

### 2. 数据层

- **PuzzleCellModelProtocol**：单元格模型协议，定义了单元格的基本属性和方法
- **PuzzleBaseCellModel**：基础单元格模型，提供了通用实现
- **PuzzleListCellModel**：列表单元格模型
- **PuzzleGridCellModel**：网格单元格模型

### 3. 通信层

- **PuzzleEventBus**：事件总线，负责组件间通信
- **PuzzleBroadcaster**：事件广播器，提供观察者模式的实现

### 4. 工具层

- 布局工具、扩展函数等辅助功能
- **PuzzleBaseCellModel**：基础单元格模型，提供了通用实现
- **PuzzleListCellModel**：列表单元格模型
- **PuzzleGridCellModel**：网格单元格模型

### 3. 通信层

- **PuzzleEventBus**：事件总线，负责组件间通信
- **PuzzleBroadcaster**：事件广播器，提供观察者模式的实现

### 4. 工具层

- 布局工具、扩展函数等辅助功能

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PuzzleKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PuzzleKit'
```

## Author

haoxuezhi, <haoxz_developer@163.com>

## License

PuzzleKit is available under the MIT license. See the LICENSE file for more info.
