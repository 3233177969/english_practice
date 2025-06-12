import { AnswerStatus } from '../model/enums/AnswerStatus'
import { OptionStatus } from '../model/enums/OptionStatus'

@Component
export default struct OptionButton {
  option: string = ''
  answer: string = ''
  @State optionStatus: OptionStatus = OptionStatus.Default
  @Prop selectedOption: string // 用户选择的选项
  @Prop @Watch('onAnswerStatusChange') answerStatus: AnswerStatus // 作答状态

  // Prop 变量的更新顺序和声明顺序是一样的，因此 answerStatus 应该在 selectedOption 之后声明

  onAnswerStatusChange() {
    if (this.option === this.answer) { // 自己是正确答案，改为绿色
      this.optionStatus = OptionStatus.Right
    } else { // 自己不是正确答案
      if (this.option === this.selectedOption) { // 自己是用户选择的选项，改为红色
        this.optionStatus = OptionStatus.Wrong
      } else { // 自己不是用户选择的选项，不改变样式
        this.optionStatus = OptionStatus.Default
      }
    }
  }

  // 根据选项按钮状态选择按钮颜色
  getBgColor() {
    switch (this.optionStatus) {
      case OptionStatus.Right:
        return "#1DBF7B"
      case OptionStatus.Wrong:
        return "#FA635F"
      default:
        return Color.White
    }
  }

  build() {
    Stack() { // 将选项按钮和勾叉图标堆叠在一起
      // 选项按钮
      Button(this.option)
        .optionButtonStyle({
          bg: this.getBgColor(),
          font: this.optionStatus === OptionStatus.Default ? Color.Black : Color.White
        })
      // 勾叉图标
      if (this.optionStatus === OptionStatus.Right) {
        Image($r('app.media.ic_right'))
          .optionImageStyle()
      } else if (this.optionStatus === OptionStatus.Wrong) {
        Image($r('app.media.ic_wrong'))
          .optionImageStyle()
      }
    }
    .alignContent(Alignment.Start)
  }
}

@Styles
function optionImageStyle() {
  .width(22)
  .height(22)
  .offset({ x: 10 })
}

@Extend(Button)
function optionButtonStyle(color: ControlButtonInterface) {
  .width(240)
  .height(48)
  .fontSize(16)
  .type(ButtonType.Normal)
  .fontWeight(FontWeight.Medium)
  .borderRadius(8)
  .backgroundColor(color.bg)
  .fontColor(color.font)
}

interface ControlButtonInterface {
  bg: ResourceColor;
  border?: ResourceColor;
  font: ResourceColor;
}