@Component
export default struct StatItem {
  icon: Resource = $r('app.media.icon');
  name: string = '';
  @BuilderParam statComp: () => void
  fontColor: Color = Color.Black

  build() {
    Row({ space: 10 }) {
      Image(this.icon)
        .height(14)
        .width(14)

      Text(this.name)
        .fontWeight(FontWeight.Medium)
        .fontSize(14)
        .fontColor(this.fontColor)

      Blank()
      this.statComp()
    }
    .width('100%')
    .height(30)
  }
}