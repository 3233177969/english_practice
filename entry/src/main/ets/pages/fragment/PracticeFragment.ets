import { AnswerStatus } from '../../model/enums/AnswerStatus'
import { PracticeStatus } from '../../model/enums/PracticeStatus'
import { getRandomQuestions, Question } from '../../model/MyData'
import { promptAction } from '@kit.ArkUI'
import OptionButton from '../../component/OptionButton'
import StatItem from '../../component/StatItem'
import ResultDialog from '../../component/ExamResultDialog'

@Preview
@Component
export default struct PracticeFragment {
  @State practiceStatus: PracticeStatus = PracticeStatus.Stopped
  @State totalCount: number = 10 //
  @State questions: Question[] = getRandomQuestions(this.totalCount)
  @State currentIndex: number = 0
  @State answerStatus: AnswerStatus = AnswerStatus.Answering // 作答状态
  @State selectedOption: string = ''
  @State answeredCount: number = 0 // 已回答题目的数量
  @State rightCount: number = 0 // 回答正确题目的数量
  timerController: TextTimerController = new TextTimerController()
  timeUsed: number = 0
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ResultDialog({
      answeredCount: this.answeredCount,
      rightCount: this.rightCount,
      timeUsed: this.timeUsed,
      onResetPractice: () => { // 重置测试的函数
        this.resetPractice()
      },
      onStartPractice: () => { // 开始测试的函数
        this.startPractice()
      }
    }),
    customStyle: true, // 允许使用自定义的弹窗样式
    autoCancel: false  // 不允许点击遮障层退出
  })

  resetPractice() {
    this.questions = getRandomQuestions(this.totalCount)
    this.currentIndex = 0
    this.answeredCount = 0
    this.rightCount = 0
    this.timeUsed = 0
    this.timerController.reset()
    this.answeredCount = AnswerStatus.Answering
  }

  startPractice() {
    this.practiceStatus = PracticeStatus.Running
    // 启动定时器
    this.timerController.start()
  }

  pausePractice() {
    this.practiceStatus = PracticeStatus.Paused
    // 暂停定时器
    this.timerController.pause()
  }

  stopPractice() {
    this.practiceStatus = PracticeStatus.Stopped
    // 停止定时器
    this.timerController.pause()
    // 弹窗
    this.dialogController.open()
  }

  build() {
    Column() {
      Column() {
        // 准确率
        StatItem({
          icon: $r('app.media.ic_accuracy'),
          name: "准确率",
          fontColor: Color.Black,
        }) { // 自定义组件中只有一个 @BuilderParam，可以用大括号的方式传参
          Text((this.answeredCount === 0 ? 0 : this.rightCount / this.answeredCount * 100).toFixed() + '%')
            .width(100)
            .textAlign(TextAlign.Center)
        }

        // 进度
        StatItem({
          icon: $r('app.media.ic_progress'),
          name: "进度",
          fontColor: Color.Black,
        }) {
          Progress({ value: this.answeredCount, total: this.totalCount })// 进度条
            .width(100)
        }

        // 个数
        StatItem({
          icon: $r('app.media.ic_count'),
          name: "个数",
          fontColor: Color.Black,
        }) {
          Button(`${this.answeredCount}/${this.totalCount}`)
            .width(100)
            .height(25)
            .backgroundColor('#EBEBEB')
            .fontColor(Color.Black)
            .enabled(this.practiceStatus === PracticeStatus.Stopped)
            .onClick(() => {
              TextPickerDialog.show({
                // 文本选择器
                range: ['5', '10', '15', '20'],
                value: this.totalCount.toString(),
                onAccept: (result: TextPickerResult) => { // 选择了新的题目个数
                  this.totalCount = parseInt(result.value as string) // 更新题目个数
                  this.questions = getRandomQuestions(this.totalCount) // 获取新题目
                }
              })
            })
        }

        // 用时
        StatItem({
          icon: $r('app.media.ic_timer'),
          name: "用时",
          fontColor: Color.Black,
        }) {
          Row() {
            TextTimer({ controller: this.timerController })// 计时器组件
              .onTimer((utc, elapsedTime) => { // 计时器每次改变，都会出发 onTimer 事件
                this.timeUsed = elapsedTime
              })
          }.width(100)
          .justifyContent(FlexAlign.Center)
        }
      }.statBgStyle()


      // 题目
      Column() {
        Text(this.questions[this.currentIndex].word).wordStyle()
        Text(this.questions[this.currentIndex].sentence).sentenceStyle()
      }

      // 选项
      Column({ space: 12 }) {
        ForEach(this.questions[this.currentIndex].options, (option: string) => {
          OptionButton({
            option: option, // 选项字符串
            answer: this.questions[this.currentIndex].answer, // 正确答案字符串
            selectedOption: this.selectedOption,
            answerStatus: this.answerStatus
          })
            .enabled(this.answerStatus === AnswerStatus.Answering)// 作答中，按钮可用
            .onClick(() => {
              // 判断练习状态
              if (this.practiceStatus !== PracticeStatus.Running) {
                promptAction.showToast({ message: "请先点击开始测试" })
                return
              }

              // 判断正误
              this.selectedOption = option

              // 更新统计信息
              this.answeredCount++
              if (option === this.questions[this.currentIndex].answer) {
                this.rightCount++
              }

              // 切换题目
              this.answerStatus = AnswerStatus.Answered // 按下选项按钮，转换为已作答状态，选项按钮不可用
              if (this.currentIndex < this.questions.length - 1) { // 不是最后一题，切换题目
                setTimeout(() => { // 延时 1000ms 后，currentIndex 加 1，切换题目
                  this.currentIndex++
                  this.answerStatus = AnswerStatus.Answering
                }, 1000)
              } else { // 是最后一题，停止测试
                this.stopPractice()
              }
            })
        }, (option: string) => this.questions[this.currentIndex].word + '-' + option) // ForEach 的第三个参数，每当它改变的时候就重新渲染
      }

      Row({ space: 48 }) {
        Button('停止测试')
          .controlButtonStyle({
            bg: Color.Transparent,
            border: this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black,
            font: this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black
          })
          .enabled(this.practiceStatus !== PracticeStatus.Stopped)
          .onClick(() => {
            // 停止测试
            this.stopPractice()
          })

        Button(this.practiceStatus === PracticeStatus.Running ? '暂停测试' : '开始测试')
          .controlButtonStyle({
            bg: this.practiceStatus === PracticeStatus.Running ? $r('app.color.tint_main') : $r('app.color.main'),
            border: this.practiceStatus === PracticeStatus.Running ? $r('app.color.tint_main') : $r('app.color.main'),
            font: Color.White
          })
          .stateEffect(false)
          .onClick(() => {
            if (this.practiceStatus === PracticeStatus.Running) {
              // 暂停测试
              this.pausePractice()
            } else {
              // 开始测试
              this.startPractice()
            }
          })
      }

    }
    .practiceBgStyle()
  }
}

@Extend(Column)
function practiceBgStyle() {
  .width('100%')
  .height('100%')
  .backgroundImage($r('app.media.bg2'))
  .backgroundImageSize({ width: '100%', height: '100%' })
  .justifyContent(FlexAlign.SpaceEvenly)
}

@Styles
function statBgStyle() {
  .width('90%')
  .borderRadius(10)
  .backgroundColor(Color.White)
  .padding(20)
}

@Extend(Text)
function wordStyle() {
  .fontSize(50)
  .fontWeight(FontWeight.Bolder)
}

@Extend(Text)
function sentenceStyle() {
  .width('80%')
  .height(40)
  .fontSize(16)
  .fontColor('#9BA1A5')
  .fontWeight(FontWeight.Medium)
  .textAlign(TextAlign.Center)
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