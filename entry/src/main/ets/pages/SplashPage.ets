
import router from '@ohos.router';
import { Path_Login } from './LoginPage';

/**
 * 欢迎页，可以设置倒计时
 */

export const Path_splash = 'pages/SplashPage'

@Entry
@Component
struct SplashPage {
  //倒计时
  @State countDownSeconds: number = 4;
  private timeId: number = 0;
  private TAG: string = 'AdvertisingPage';

  onPageShow() {
    this.timeId = setInterval(() => {
      if (this.countDownSeconds === 0) {
        this.jumpToAppHomePage();
      } else {
        this.countDownSeconds--;
      }
    }, 1000);
  }

  onPageHide() {
    router.clear();
    clearInterval(this.timeId);
  }

  /**
   * 跳转到主页.
   */
  jumpToAppHomePage() {
    router.pushUrl({
      url: Path_Login
    }).catch((error: Error) => {
      //Logger.error(this.TAG, 'AdvertisingPage pushUrl error ' + JSON.stringify(error));
    });
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Image($r('app.media.splash'))
        .width('100%')
        .height('100%')
      Text($r('app.string.advertising_text_title', this.countDownSeconds))
        .fontColor(Color.White)
        .fontSize('12fp')
        .letterSpacing(0.05)
        .backgroundColor('#33000000')
        .border({
          radius: '18vp',
          width: '1',
          color: Color.White
        })
        .margin({
          top: '50vp',
          left: '260vp'
        })
        .padding({
          left: '12vp',
          top: '8vp',
          right: '12vp',
          bottom: '8vp'
        })
        .onClick(() => {
          this.jumpToAppHomePage();
        })
    }
    .width('100%')
    .height('100%')
  }
}