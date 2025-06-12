import { bannerList } from "../model/MyData"

@Component
export default struct BannerView {

  build() {
    Column() {
      Swiper() {
        ForEach(bannerList, (item: Resource) => {
          Image(item)
            .width('95%')
            .height('160vp')
        })
      }
      .index(0) //初始化索引值
      .autoPlay(true) //自动播放
      .interval(3000) //自动播放间隔时间，默认3000
      .loop(true) //是否开启循环
      .duration(1000) //切换的动画时长
      .itemSpace(5) //图片间隙，默认为0
      .indicator(true) //是否启用导航指示器，默认true
      .indicatorStyle({color: Color.Black})
      .borderRadius(6)
      .margin({top:30})
    }
    .width('100%')
    .margin({top:'5vp'})

  }
}