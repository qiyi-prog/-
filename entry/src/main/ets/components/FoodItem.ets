import { Food } from '../models/FoodModel';

interface FoodItemProps {
  food: Food;
  onAddToCart: (food: Food) => void;
  onRemoveFromCart: (food: Food) => void;
}

@Component
export default struct FoodItem {
  @ObjectLink food: Food;
  onAddToCart: (food: Food) => void = () => {};
  onRemoveFromCart: (food: Food) => void = () => {};

  build() {
    Row() {
      // 食品图片
      Image(this.food.picture)
        .width(80)
        .height(80)
        .borderRadius(4)
        .objectFit(ImageFit.Cover)
        .margin({ right: 12 })

      // 食品信息
      Column() {
        // 食品名称
        Text(this.food.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.black'))
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        // 食品描述
        Text(this.food.description)
          .fontSize(12)
          .fontColor($r('app.color.food_item_second_color'))
          .margin({ top: 4 })
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        // 销售量和规格
        Row() {
          Text('月销' + this.food.month_saled)
            .fontSize(11)
            .fontColor($r('app.color.search_font_color'))
          Blank()
          Text(this.food.unit)
            .fontSize(11)
            .fontColor($r('app.color.search_font_color'))
        }
        .width('100%')
        .margin({ top: 8 })

        // 价格和数量控制
        Row() {
          Text('¥' + this.food.price)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.main_color'))

          Blank()

          // 数量控制
          if ((this.food.cartCount || 0) > 0) {
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
                .onClick(() => this.onRemoveFromCart(this.food))

              Text((this.food.cartCount || 0).toString())
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
                .onClick(() => this.onAddToCart(this.food))
            }
            .gap(4)
          } else {
            Button('+')
              .width(24)
              .height(24)
              .fontSize(12)
              .fontColor($r('app.color.white'))
              .backgroundColor($r('app.color.main_color'))
              .borderRadius(2)
              .onClick(() => this.onAddToCart(this.food))
          }
        }
        .width('100%')
        .margin({ top: 8 })
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height(100)
    .padding(12)
    .borderBottom({
      width: 1,
      color: $r('app.color.top_border_color')
    })
    .alignItems(VerticalAlign.Center)
  }
}