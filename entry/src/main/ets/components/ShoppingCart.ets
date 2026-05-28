import { CartItem, Food } from '../models/FoodModel';

interface ShoppingCartProps {
  items: CartItem[];
  onRemove: (food: Food) => void;
  onAdd: (food: Food) => void;
  onClear: () => void;
  onClose: () => void;
}

@Component
export default struct ShoppingCart {
  @Link items: CartItem[];
  onRemove: (food: Food) => void = () => {};
  onAdd: (food: Food) => void = () => {};
  onClear: () => void = () => {};
  onClose: () => void = () => {};
  @State totalPrice: number = 0;

  aboutToAppear() {
    this.updateTotalPrice();
  }

  updateTotalPrice() {
    this.totalPrice = this.items.reduce((sum, item) => {
      return sum + item.price * item.cartCount;
    }, 0);
  }

  build() {
    Column() {
      // 黑色半透明背景
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.5)')
        .onClick(() => this.onClose())

      // 购物车内容
      Column() {
        // 标题
        Row() {
          Text('购物车')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.black'))
          Blank()
          Button('✕')
            .width(30)
            .height(30)
            .fontSize(16)
            .fontColor($r('app.color.black'))
            .backgroundColor(Color.Transparent)
            .onClick(() => this.onClose())
        }
        .width('100%')
        .height(50)
        .padding(16)
        .borderBottom({
          width: 1,
          color: $r('app.color.top_border_color')
        })
        .alignItems(VerticalAlign.Center)

        // 购物车列表
        if (this.items.length > 0) {
          List() {
            ForEach(this.items, (item: CartItem) => {
              ListItem() {
                Row() {
                  Column() {
                    Text(item.name)
                      .fontSize(14)
                      .fontColor($r('app.color.black'))
                      .fontWeight(FontWeight.Bold)
                    Text('¥' + item.price)
                      .fontSize(12)
                      .fontColor($r('app.color.main_color'))
                      .margin({ top: 4 })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)

                  Row() {
                    Button('-')
                      .width(24)
                      .height(24)
                      .fontSize(12)
                      .fontColor($r('app.color.main_color'))
                      .backgroundColor(Color.Transparent)
                      .borderRadius(2)
                      .border({
                        width: 1,
                        color: $r('app.color.main_color')
                      })
                      .onClick(() => this.onRemove(item))

                    Text(item.cartCount.toString())
                      .fontSize(12)
                      .margin({ left: 8, right: 8 })
                      .fontColor($r('app.color.black'))

                    Button('+')
                      .width(24)
                      .height(24)
                      .fontSize(12)
                      .fontColor($r('app.color.white'))
                      .backgroundColor($r('app.color.main_color'))
                      .borderRadius(2)
                      .onClick(() => this.onAdd(item))
                  }
                  .gap(4)
                }
                .width('100%')
                .height(70)
                .padding(12)
                .borderBottom({
                  width: 1,
                  color: $r('app.color.top_border_color')
                })
                .alignItems(VerticalAlign.Center)
              }
            }, (item: CartItem) => item.id.toString())
          }
          .width('100%')
          .layoutWeight(1)
        } else {
          Column() {
            Text('购物车为空')
              .fontSize(14)
              .fontColor($r('app.color.search_font_color'))
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }

        // 底部操作
        if (this.items.length > 0) {
          Row() {
            Text('合计: ¥' + this.totalPrice.toFixed(2))
              .fontSize(14)
              .fontColor($r('app.color.main_color'))
              .fontWeight(FontWeight.Bold)
              .layoutWeight(1)

            Button('清空购物车')
              .fontSize(12)
              .fontColor($r('app.color.white'))
              .backgroundColor($r('app.color.font_main_color'))
              .borderRadius(4)
              .padding({ left: 12, right: 12 })
              .onClick(() => this.onClear())
          }
          .width('100%')
          .height(50)
          .padding(12)
          .backgroundColor($r('app.color.left_back_color'))
          .alignItems(VerticalAlign.Center)
        }
      }
      .width('100%')
      .height('70%')
      .margin({ top: 'auto' })
      .backgroundColor($r('app.color.white'))
      .borderRadius({ topLeft: 12, topRight: 12 })
    }
    .width('100%')
    .height('100%')
    .position({ x: 0, y: 0 })
  }
}