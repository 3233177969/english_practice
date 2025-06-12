import StatItem from './StatItem';
import { promptAction, router } from '@kit.ArkUI';
import { emitter } from '@kit.BasicServicesKit';
import { convertMillisecondsToTime } from '../util/DateUtil';
import { Constants } from '../util/Constant';

@CustomDialog
export default struct ExamResultDialog {
  answeredCount: number = 0;
  rightCount: number = 0;
  timeUsed: number = 0;
  onResetPractice: () => void = () => {
  }
  onStartPractice: () => void = () => {
  }
  controller: CustomDialogController = new CustomDialogController({
    builder: ExamResultDialog()  // DialogController 用于控制当前弹窗
  })
  @StorageProp('token') token: string = '' // 与 PersistentStorage 中的 token 进行单向链接
  @StorageLink('currentTabIndex') currentTabIndex: number = 0;

  build() {
    Column({ space: 12 }) {
      Image($r('app.media.ic_close'))// 关闭
        .width(25)
        .height(25)
        .alignSelf(ItemAlign.End)
        .onClick(() => {
          this.controller.close()
          this.onResetPractice()
        })

      Column({ space: 12 }) {
        Image($r('app.media.guzhang'))
          .width('100%')
          .borderRadius(10)

        StatItem({
          icon: $r('app.media.ic_timer'),
          name: '用时',
          fontColor: Color.Black
        }) {
          Text(convertMillisecondsToTime(this.timeUsed))
        }

        StatItem({
          icon: $r('app.media.ic_accuracy'),
          name: '准确率',
          fontColor: Color.Black
        }) {
          Text((this.answeredCount === 0 ? 0 : this.rightCount / this.answeredCount * 100).toFixed() + '%')
        }

        StatItem({
          icon: $r('app.media.ic_count'),
          name: '个数',
          fontColor: Color.Black
        }) {
          Text(this.answeredCount.toString())
        }

        Divider() // 分割线

        Row({ space: 30 }) {
          Button("再来一局")
            .controlButtonStyle({
              bg: Color.Transparent,
              border: Color.Black,
              font: Color.Black
            })
            .onClick(() => {
              this.controller.close()
              this.onResetPractice() // 按下“再来一局”，重启测试
              this.onStartPractice() // 重启测试后，开始测试
            })

          /*
          Button(this.token ? "立即打卡" : "登录打卡")
            .controlButtonStyle({
              bg: Color.Black,
              border: Color.Black,
              font: Color.White
            })
            .onClick(async () => {
              this.controller.close()
              this.onResetPractice() // 重启测试
              // 登录并打卡
              if (this.token) { // 已登录
                // 发送打卡请求
                // await createPost({
                //   // 等待请求完成后再执行接下来的指令
                //   rightCount: this.rightCount,
                //   answeredCount: this.answeredCount,
                //   timeUsed: this.timeUsed
                // })
                promptAction.showToast({ message: '打卡成功' })
                // 通知打卡圈页面提交了新的打卡记录
                emitter.emit({ eventId: Constants.REFRESH_CIRCLE })
                // 跳转到打卡圈
                this.currentTabIndex = 1
              } else { // 未登录
                // 跳转到登录页面
                router.pushUrl({
                  url: 'pages/LoginPage', params: {
                    // 切换页面，也可以返回，路由时传递必要的参数
                    rightCount: this.rightCount,
                    answeredCount: this.answeredCount,
                    timeUsed: this.timeUsed
                  }
                })
              }
            })
          */
        }
      }.backgroundColor(Color.White)
      .width('100%')
      .padding(20)
      .borderRadius(10)

    }.backgroundColor(Color.Transparent)
    .width('80%')
  }
}

interface ControlButtonInterface {
  bg: ResourceColor;
  border?: ResourceColor;
  font: ResourceColor;
}

@Extend(Button)
function controlButtonStyle(color: ControlButtonInterface) {
  .fontSize(16)
  .borderWidth(1)
  .backgroundColor(color.bg)
  .borderColor(color.border)
  .fontColor(color.font)
}