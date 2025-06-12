import { homeLevelList, LevelBean } from "../model/MyData"
import { promptAction } from "@kit.ArkUI"

@Component
export default struct HomeListView {
  //一经选择的等级
  @State selectLevel: string = '还未选择'

  build() {
    Column() {
      Row() {
        Text('请选择英语等级')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        // Text(`(已选择的级别: ${this.selectLevel})`)
        //   .fontSize(12)
        //   .margin({left:10})
      }
      .alignSelf(ItemAlign.Start)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({
        top: 20,
        right: 16,
        left: 6,
        bottom: 10
      })

      // 列表
      List({ space: 12 }) {
        ForEach(homeLevelList, (item: LevelBean) => {
          ListItem() {
            Column() {
              Text(item.title)
                // .fontColor($r('app.color.main'))
                //.fontColor('#ff57a9ea')
                .fontColor('#ff2f99ec')
                .fontSize('18fp')
                .maxLines(1)
                .fontWeight(600)
              Text(item.des)
                .fontSize('14fp')
                //.fontColor($r('app.color.tint_main'))
                .fontColor('#c857a9ea')
                // .fontColor('#ff7e7b7b')
                // .fontColor('#ffffff')
                .margin({ top: 5 })
                .maxLines(2)
                .ellipsisMode(EllipsisMode.END)
            }
            .backgroundColor(item.bgColor)
            .height(90)
            .width('100%')
            .borderRadius(10)
            .padding(16)
            .alignItems(HorizontalAlign.Start)
            .onClick(()=>{
              promptAction.showToast({
                message: '选择成功',
                duration: 1000,
                bottom: '360vp'
              })
              this.selectLevel = item.title
            })
          }
          .margin({ left: '5vp', right: '5vp' })
        })
      }
      .width('95%')

      //.lanes(2) // 排列个数
    }
  }
}