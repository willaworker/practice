@Entry
@Component
struct Index {
  @State message: string = '记事本'
  controller: TextInputController = new TextInputController()
  @State arr: string[] = ['这是一条示例', '输入任务并点击加号以添加任务', '左滑删除']
  private scroller: ListScroller = new ListScroller()
  @State text: string = ''

  @Builder
  itemEnd(index: number) {
    Row() {
      Button("Delete").margin("4vp").onClick(() => {
        this.arr.splice(index, 1) // 删除对应项
      })
    }.padding("4vp").justifyContent(FlexAlign.SpaceEvenly)
  }

  build() {
    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)

      // 输入框
      Row() {
        TextInput({ text: this.text, placeholder: '请输入任务', controller: this.controller })
          .width('80%')
          .onChange((value: string) => {
            this.text = value
          })

        Button() {
          Text('＋')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .backgroundColor('#0D9FFB')
        .width('15%')
        .height('5%')
        .onClick(() => {
          if (this.text.trim() !== '') {
            this.arr.push(this.text)
            this.text = '' // 添加任务后清空输入框
          }
        })
      }
      .width('80%')
      .margin({ top: 20 })

      // 反向输出的列表
      List({ space: 10, scroller: this.scroller }) {
        ForEach(this.arr.slice().reverse(), (item: string, index: number) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(100)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
              .backgroundColor(0xFFFFFF)
          }
          .transition({ type: TransitionType.Delete, opacity: 1000 })
          .swipeAction({
            end: {
              builder: () => {
                this.itemEnd(this.arr.length - 1 - index) // 修正索引
              },
              onAction: () => {
                animateTo({ duration: 1000 }, () => {
                  this.arr.splice(this.arr.length - 1 - index, 1) // 删除项
                })
              },
              actionAreaDistance: 56,
            }
          })
        }, (item: string) => item)
      }
      .margin({ top: 20 })
      .width('100%')
      .height('80%')
    }
    .padding(10)
    .backgroundColor(0xDCDCDC)
    .width('100%')
    .height('100%')
  }
}
