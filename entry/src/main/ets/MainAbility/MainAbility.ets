import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';

const TAG: string = 'MainAbility';

export default class MainAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, TAG, '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, TAG, '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    hilog.info(0x0000, TAG, '%{public}s', 'Ability onWindowStageCreate');
    windowStage.loadContent('pages/FoodOrderPage', (err) => {
      if (err.code) {
        hilog.error(0x0000, TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, TAG, 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy() {
    hilog.info(0x0000, TAG, '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    hilog.info(0x0000, TAG, '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    hilog.info(0x0000, TAG, '%{public}s', 'Ability onBackground');
  }
}