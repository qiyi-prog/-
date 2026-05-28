import { FoodCategory, Food } from '../models/FoodModel';
import FoodItem from './FoodItem';

interface FoodListProps {
  categories: FoodCategory[];
  onAddToCart: (food: Food) => void;
  onRemoveFromCart: (food: Food) => void;
}

@Component
export default struct FoodList {
  @Prop categories: FoodCategory[] = [];
  onAddToCart: (food: Food) => void = () => {};
  onRemoveFromCart: (food: Food) => void = () => {};
  @State scroller: Scroller = new Scroller();

  build() {
    Row() {
      // 左侧分类列表
      Column() {
        List({ scroller: this.scroller }) {
          ForEach(this.categories, (category: FoodCategory) => {
            ListItem() {
              Text(category.name)
                .fontSize(14)
                .fontColor($r('app.color.white'))
                .width('100%')
                .padding(12)
                .backgroundColor($r('app.color.bottom_back'))
                .textAlign(TextAlign.Center)
                .border({
                  width: { left: 3 },
                  color: $r('app.color.main_color')
                })
            }
            .height(50)
          }, (category: FoodCategory) => category.tag)
        }
        .width('100%')
        .height('100%')
      }
      .width(100)
      .height('100%')
      .backgroundColor($r('app.color.left_back_color'))

      // 右侧食品列表
      Column() {
        List() {
          ForEach(this.categories, (category: FoodCategory) => {
            ListItemGroup({ header: this.CategoryHeader(category.name) }) {
              ForEach(category.foods, (food: Food) => {
                ListItem() {
                  FoodItem({
                    food: food,
                    onAddToCart: (f: Food) => this.onAddToCart(f),
                    onRemoveFromCart: (f: Food) => this.onRemoveFromCart(f)
                  })
                }
              }, (food: Food) => food.id.toString())
            }
          }, (category: FoodCategory) => category.tag)
        }
        .width('100%')
        .height('100%')
      }
      .layoutWeight(1)
      .height('100%')
      .backgroundColor($r('app.color.white'))
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  CategoryHeader(name: string) {
    Column() {
      Text(name)
        .fontSize(14)
        .fontColor($r('app.color.font_main_color'))
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .padding(12)
        .backgroundColor($r('app.color.search_back_color'))
    }
    .width('100%')
    .backgroundColor($r('app.color.search_back_color'))
  }
}