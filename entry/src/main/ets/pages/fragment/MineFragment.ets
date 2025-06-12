import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { AxiosResponse } from '@ohos/axios';

interface UserInterface {
  nickname?: string;
  avatarUrl?: string;
}
@Preview
@Component
export struct MineFragment {

  async aboutToAppear() {

  }

  build() {
    Stack() {
      Column() {
        Image($r('app.media.meinv'))
          .width(100)
          .height(100)
          .borderRadius(50)
          .margin({ top: 120 })
          .onClick(() => {

          })

        Text()
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 20 })

      }
      .width('100%')
      .height('50%')
      .backgroundImage($r('app.media.bg2'))
      .backgroundImageSize({ height: '100%', width: '100%' })
      .backgroundBlurStyle(BlurStyle.Regular)

      Column({ space: 10 }) {
        this.mineItemBuilder($r('app.media.huizhang'), '历史打分')
        Divider()
        this.mineItemBuilder($r('app.media.jihua'), '明日再战')
        Divider()
        this.mineItemBuilder($r('app.media.yinsi'), '隐私政策')
        Divider()
        this.mineItemBuilder($r('app.media.guanyu'), '关于我们')

        Blank()
        Button('退出登录')
          .width('100%')
          .fontSize(18)
          .backgroundColor(Color.Gray)
          .fontColor(Color.White)
          .onClick(() => {
            router.back()
          })
      }
      .width('100%')
      .height('60%')
      .offset({ y: '40%' })
      .borderRadius({ topLeft: 50, topRight: 50 })
      .backgroundColor(Color.White)
      .padding(30)

    }.width('100%')
    .height('100%')
    .alignContent(Alignment.Top)
  }

  @Builder
  mineItemBuilder(icon: Resource, title: string, callback?: () => void) {
    Row({ space: 10 }) {
      Image(icon)
        .width(24)
        .height(24)
      Text(title)
        .fontSize(16)
        .height(24)
        .fontWeight(FontWeight.Medium)
      Blank()
      Image($r('app.media.ic_arrow_right'))
        .width(24)
        .height(24)
    }.width('100%')
    .height(40)
    .onClick(() => {
      callback && callback();
    })
  }
}