import HomeFragment from './fragment/HomeFragment';
import { MineFragment } from './fragment/MineFragment';
import PracticeFragment from './fragment/PracticeFragment';
import PracticePage from './fragment/PracticeFragment';

export let Path_Main = 'pages/MainPage'

@Entry
@Component
struct MainPage {
  @StorageLink('currentTabIndex') currentTabIndex: number = 0; // 被选中的页签索引

  build() {
    Tabs({ index: this.currentTabIndex }) { // index 指示 Tabs 显示哪个页面
      TabContent() {
        HomeFragment()
      }.tabBar(this.barBuilder(0, '分类', $r('app.media.fenlei'), $r('app.media.fenlei_unselect')))

      TabContent() {
        PracticeFragment()
      }.tabBar(this.barBuilder(1, '背词', $r('app.media.ic_practice'), $r('app.media.ic_practice_selected')))

      TabContent() {
        MineFragment()
      }.tabBar(this.barBuilder(2, '我的', $r('app.media.mine_unselect'), $r('app.media.mine_select')))

    }.barPosition(BarPosition.End) // 导航栏位于页面底部
    .onChange((index) => { // 选择新的页签时，修改被选中的页签索引
      this.currentTabIndex = index;
    })
    .padding({ bottom: 20 })
  }

  // 自定义页签结构，根据被选中的页签索引决定每一个页签的样式
  @Builder
  barBuilder(index: number, title: string, icon: Resource, iconSelected: Resource) {
    Column() {
      Image(this.currentTabIndex === index ? iconSelected : icon)
        .width(25)
        .height(25)
        .margin({ top: 10 })
      Text(title)
        .tabTitleStyle(this.currentTabIndex === index ? Color.Black : '#959595')
    }
  }
}

@Extend(Text)
function tabTitleStyle(color: ResourceColor) {
  .fontSize(14)
  .fontWeight(FontWeight.Medium)
  .fontColor(color) //Color.Black
  .margin({ bottom: 2, top: 5 })
}

