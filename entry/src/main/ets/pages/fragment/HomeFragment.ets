import BannerView from "../../component/BannerView"
import HomeListView from "../../component/HomeListView"

@Preview
@Component
export default struct HomeFragment {
  //@State message: string = MyData.bottombeanList[0]

  build() {
    Scroll() {
      Column() {
        // 轮播图
        BannerView()

        // 列表
        HomeListView()
      }.width('100%')
    }
    .scrollBar(BarState.Auto)
  }
}